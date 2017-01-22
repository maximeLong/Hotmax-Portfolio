<template>
  <div id="three">
  </div>
</template>

<style lang="sass">
@import src/styles/main
#three
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  overflow: hidden
</style>

<script lang="coffee">
THREE = require 'three'
_ = require 'lodash'
{ EffectComposer, BloomPass, RenderPass, FilmPass, GlitchPass } = require 'postprocessing'

module.exports =
  name: 'three'
  props:
    mode: String

  data: ->
    rotationalParents: []
    orbitTracks: []
    planetParents: []
    planets: []
    glitch: false


  mounted: ->
    # set up scene and camera
    scene = new THREE.Scene()
    @HEIGHT = window.innerHeight
    @WIDTH = window.innerWidth

    # window.addEventListener('resize', handleWindowResize, false) # update the camera and the renderer size on window resize

    camera = new THREE.PerspectiveCamera( 75, @WIDTH / @HEIGHT, 0.1, 1000 )
    camera.position.z = 5

    renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true }) # web gl renderer, appended to component body
    renderer.setSize( @WIDTH, @HEIGHT )
    renderer.shadowMap.enabled = true
    @$el.appendChild( renderer.domElement )

    # parent container
    @map = new THREE.Object3D()
    scene.add(@map)

    # build sun mesh
    sunGeo = new THREE.TetrahedronGeometry( 1,3 )
    sunMat = new THREE.MeshPhongMaterial({
      color: 0xef5e6c
      name: 'sun'
      shininess: 10
      specular: 0xffffff
      shading: THREE.FlatShading
    })
    @sunMesh = new THREE.Mesh( sunGeo, sunMat )
    @sunMesh.receiveShadow = true
    @map.add( @sunMesh )

    # add track/planet parent object -- used for rotation
    for i in [0...4]
      parent = new THREE.Object3D()
      parent.rotation.x += .4
      @rotationalParents.push( parent )
      @map.add( parent )

    # build orbiting 'tracks'
    @lineFactory(@orbitTracks, 'track')
    for line in @orbitTracks
      @map.add( line )

    # build planet container and planet
    for i in [0...4]
      planetParent = new THREE.Object3D()
      # planetParent.position.x = i * Math.PI / 3
      planetParent.position.x = @orbitTracks[i].geometry.parameters.radiusTop
      @planetParents.push( planetParent )
      @rotationalParents[i].add( planetParent )

    @lineFactory(@planets, 'planet')
    for planet,i in @planets
      @planetParents[i].add( planet )


    scene.fog = new THREE.Fog(0xf7d9aa, 100,950)                        # fog??
    hemisphereLight = new THREE.HemisphereLight(0xb98a5b,0x000000, .9)  # lighting
    shadowLight = new THREE.DirectionalLight(0xb98a5b, .9)
    shadowLight.position.set(5, 5, 10)
    shadowLight.castShadow = true
    scene.add( hemisphereLight )
    scene.add( shadowLight )

    # set up effect composer and then pass
    composer1 = new EffectComposer(renderer)
    composer1.addPass(new RenderPass( scene, camera ))
    composer2 = new EffectComposer(renderer)
    composer2.addPass(new RenderPass( scene, camera ))
    composer3 = new EffectComposer(renderer)
    composer3.addPass(new RenderPass( scene, camera ))

    filmPass = new FilmPass({     # film pass -- used for entry
      noiseIntensity:     0.5
      scanlineIntensity:  0.4
      scanlineDensity:    1.2
      vignette:           true
      vignetteOffset:     0.5
      vignetteDarkness:   0.75
    })
    glitchPass = new GlitchPass() # glitch pass and default mode -- used for transition
    glitchPass.mode = 1
    bloomPass = new BloomPass({   # bloom pass -- used for desktop
      resolution:  0.5
      blurriness:  1.0
      strength:    1.1
      distinction: -0.75
    })
    bloomPass.renderToScreen  = false    # rendering options
    glitchPass.renderToScreen = false
    filmPass.renderToScreen   = true
    @$watch 'glitch', (newVal,oldVal)->
      if newVal == true
        glitchPass.renderToScreen = true
      else
        glitchPass.renderToScreen = false

    composer1.addPass(filmPass)
    composer2.addPass(glitchPass)
    composer3.addPass(bloomPass)
    clock = new THREE.Clock()   # clock needed for pass

    mouse = new THREE.Vector2()           # raycasting and mouse position
    raycaster = new THREE.Raycaster()
    window.addEventListener 'mousemove', (e)=>
      mouse.x = ( event.clientX / @WIDTH ) * 2 - 1
      mouse.y = - ( event.clientY / @HEIGHT ) * 2 + 1
    , false
    mousePoint = new THREE.Vector3()

    # change camera position and pass on desktop mode change
    @$watch 'mode', (mode)=>
      if mode is 'desktop'
        camera.position.z = 3.6
        camera.position.y = 13
        camera.rotation.x = 5
        bloomPass.renderToScreen  = true
        filmPass.renderToScreen   = false

    # //////////////////////////////////////////
    #  R E N D E R   L O O P
    # /////////////////////////////////////////
    do render = ()=>
      delta = clock.getDelta()
      time = clock.getElapsedTime()

      #TODO: create entry/desktop flag and animate camera position
      # if @mode is 'desktop'

      #update the picking ray with the camera and mouse position
      raycaster.setFromCamera( mouse, camera )
      intersects = raycaster.intersectObjects( @map.children )
      # if intersects.length > 0
      #   #intersects[0].object?
      #   # do something
      # else
      #   # do something else

      # rotation
      for line,i in @orbitTracks
        @rotateOnOneAxis(line, delta/3, 'y')
      @rotateOnXYAxis(@sunMesh, delta/2)

      #opacity and mouse tracking -- TODO: create desktop flag for this behavior
      if @mode is 'desktop'
        @orbitTracks[0].rotation.x = mouse.y * 0.3
        @orbitTracks[0].rotation.z = mouse.x * 0.3
        @orbitTracks[1].rotation.x = -mouse.y * 0.15
        @orbitTracks[1].rotation.z = -mouse.x * 0.15
        @orbitTracks[2].rotation.x = mouse.y * 0.15
        @orbitTracks[2].rotation.z = mouse.x * 0.15
        @orbitTracks[3].rotation.x = -mouse.y * 0.15
        @orbitTracks[3].rotation.z = -mouse.x * 0.15


      # bobbing
      @changePosition(@orbitTracks[0], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@orbitTracks[1], (Math.sin(time) / 4) + .1, 'y')
      @changePosition(@orbitTracks[2], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@orbitTracks[3], (Math.sin(time) / 7) + .1, 'y')
      @changePosition(@planets[0], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@planets[1], (Math.sin(time) / 4) + .1, 'y')
      @changePosition(@planets[2], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@planets[3], (Math.sin(time) / 7) + .1, 'y')

      # orbiting planets
      @rotationalParents[0].rotation.y += 0.01
      @rotationalParents[1].rotation.y += 0.005
      @rotationalParents[2].rotation.y += 0.0025
      @rotationalParents[3].rotation.y += 0.00125

      requestAnimationFrame(render)
      composer1.render(delta)
      composer2.render(delta)
      composer3.render(delta)

  methods:
    turnGlitchOn: ()->
      @glitch = true
      # intersect.object?.material.color.setHex( Math.random() * 0xffffff )
    onClick: ->
      console.log 'click'

    rotateOnOneAxis: (mesh, amount, axis)->
      mesh.rotation[axis] += amount
    rotateOnXYAxis: (mesh, amount)->
      mesh.rotation.x += amount
      mesh.rotation.y += amount
    changePosition: (mesh, amount, axis)->
      mesh.position[axis] = amount

    lineFactory: (array, type)->
      for i in [3...7]
        if type is 'track' then size = i * .6
        if type is 'planet' then size = .28
        radiusTop       =  size
        radiusBottom    =  size
        height          =  0.002
        radiusSegments  =  32
        heightSegments  =  1
        lineGeo = new THREE.CylinderGeometry( radiusTop, radiusBottom, height, radiusSegments, heightSegments )
        lineMat = new THREE.LineBasicMaterial({
          color: 0xffffff
          transparent: true
        })
        lineGeo.vertices.pop()
        lineGeo.vertices.pop()
        line = new THREE.Line( lineGeo, lineMat )
        if type is 'track'
          line.rotation.x += .4
          line.rotation.y += i * 1.5
        if type is 'planet'
          line.rotation.x += 1.5
        array.push(line)


</script>
