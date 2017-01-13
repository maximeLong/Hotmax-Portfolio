<template>
  <div id="three">
    <!-- <div class="buttons">
      <button @click="turnGlitchOn">glitch it bitch</button>
    </div> -->
  </div>
</template>

<script lang="coffee">
THREE = require 'three'
_ = require 'lodash'
{ EffectComposer, BloomPass, RenderPass, FilmPass, GlitchPass } = require 'postprocessing'

module.exports =
  name: 'three'
  props:
    cameraPosition: String

  mounted: ->
    # set up scene and camera
    scene = new THREE.Scene()
    HEIGHT = window.innerHeight
    WIDTH = window.innerWidth

    # update the camera and the renderer size on window resize
    # window.addEventListener('resize', handleWindowResize, false)

    # camera
    camera = new THREE.PerspectiveCamera( 75, WIDTH / HEIGHT, 0.1, 1000 )
    #entry
    # camera.position.z = 5

    camera.position.z = 3.6
    camera.position.y = 13
    camera.rotation.x = 5

    # web gl renderer, appended to component body
    renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
    renderer.setSize( WIDTH, HEIGHT )
    renderer.shadowMap.enabled = true
    @$el.appendChild( renderer.domElement )

    # celestial Parent
    objectsContainer = new THREE.Object3D()
    scene.add(objectsContainer)

    # add geometry
    geometry = new THREE.TetrahedronGeometry( 1,3 )
    material = new THREE.MeshPhongMaterial({
      color: 0xef5e6c
      name: 'sun'
      shininess: 10
      specular: 0xffffff
      shading: THREE.FlatShading
    })
    @sunMesh = new THREE.Mesh( geometry, material )
    @sunMesh.receiveShadow = true
    objectsContainer.add( @sunMesh )

    # add orbit parent
    @parents = []
    for i in [0...4]
      parent = new THREE.Object3D()
      parent.rotation.x += .4
      @parents.push( parent )
    for parent in @parents
      objectsContainer.add( parent )

    @solarLines = []
    @lineFactory(@solarLines, 'track')
    for line in @solarLines
      objectsContainer.add( line )


    # orbiting object and add to scene
    @orbits = []
    for i in [0...4]
      orbit = new THREE.Object3D()
      # orbit.position.x = i * Math.PI / 3
      orbit.position.x = @solarLines[i].geometry.parameters.radiusTop
      @orbits.push( orbit )
    for orbit,i in @orbits
      @parents[i].add(orbit)

    # add lines
    @planetLines = []
    @lineFactory(@planetLines, 'planet')
    for planet,i in @planetLines
      @orbits[i].add( planet )


    # fog??
    scene.fog = new THREE.Fog(0xf7d9aa, 100,950)

    # lighting
    hemisphereLight = new THREE.HemisphereLight(0xb98a5b,0x000000, .9)
    shadowLight = new THREE.DirectionalLight(0xb98a5b, .9)
    # hemisphereLight = new THREE.HemisphereLight(0xb98a5b,0x000000, .9)
    # shadowLight = new THREE.DirectionalLight(0xb98a5b, .9)

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

    # film pass
    filmPass = new FilmPass({
      noiseIntensity:     0.5
      scanlineIntensity:  0.4
      scanlineDensity:    1.2
      vignette:           true
      vignetteOffset:     0.5
      vignetteDarkness:   0.75
    })
    # glitch pass
    glitchPass = new GlitchPass()
    glitchPass.mode = 1
    # bloom pass
    bloomPass = new BloomPass({
      resolution:  0.5
      blurriness:  1.0
      strength:    1.1
      distinction: -0.75
    })

    bloomPass.renderToScreen  = true
    glitchPass.renderToScreen = false
    filmPass.renderToScreen   = false
    composer1.addPass(filmPass)
    composer2.addPass(glitchPass)
    composer3.addPass(bloomPass)

    @$watch 'glitch', (newVal,oldVal)->
      if newVal == true
        glitchPass.renderToScreen = true
      else
        glitchPass.renderToScreen = false

    # this is needed for the pass for some reason
    clock = new THREE.Clock()


    # begin raycasting
    mouse = new THREE.Vector2()
    raycaster = new THREE.Raycaster()
    window.addEventListener 'mousemove', (e)->
      mouse.x = ( event.clientX / WIDTH ) * 2 - 1
      mouse.y = - ( event.clientY / HEIGHT ) * 2 + 1
    , false
    mousePoint = new THREE.Vector3()

    do render = ()=>
      delta = clock.getDelta()
      time = clock.getElapsedTime()

      #update camera position on cameraPosition Prop change
      # if @cameraPosition is 'desktop'


      #update the picking ray with the camera and mouse position
      raycaster.setFromCamera( mouse, camera )
      intersects = raycaster.intersectObjects( objectsContainer.children )
      # if intersects.length > 0
      #   #intersects[0].object?
      #   # do something
      # else
      #   # do something else



      # rotation
      for line,i in @solarLines
        @rotateOnOneAxis(line, delta/3, 'y')
      @rotateOnXYAxis(@sunMesh, delta/2)

      #opacity and mouse tracking -- set on desktop prop change
      for line,i in @solarLines
        line.material.opacity = 1
      for line,i in @planetLines
        line.material.opacity = 1

      @solarLines[0].rotation.x = mouse.y * 0.3
      @solarLines[0].rotation.z = mouse.x * 0.3
      @solarLines[1].rotation.x = -mouse.y * 0.15
      @solarLines[1].rotation.z = -mouse.x * 0.15
      @solarLines[2].rotation.x = mouse.y * 0.15
      @solarLines[2].rotation.z = mouse.x * 0.15
      @solarLines[3].rotation.x = -mouse.y * 0.15
      @solarLines[3].rotation.z = -mouse.x * 0.15

      # objectsContainer.rotation.x = mouse.y * 0.15
      # objectsContainer.rotation.z = mouse.x * 0.15

      # bobbing
      @changePosition(@solarLines[0], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@solarLines[1], (Math.sin(time) / 4) + .1, 'y')
      @changePosition(@solarLines[2], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@solarLines[3], (Math.sin(time) / 7) + .1, 'y')

      @changePosition(@planetLines[0], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@planetLines[1], (Math.sin(time) / 4) + .1, 'y')
      @changePosition(@planetLines[2], (Math.sin(time) / 5) + .1, 'y')
      @changePosition(@planetLines[3], (Math.sin(time) / 7) + .1, 'y')

      # orbiting planets
      @parents[0].rotation.y += 0.01
      @parents[1].rotation.y += 0.005
      @parents[2].rotation.y += 0.0025
      @parents[3].rotation.y += 0.00125

      requestAnimationFrame(render)
      composer1.render(delta)
      composer2.render(delta)
      composer3.render(delta)

  data: ->
    glitch: false

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
    changePositionOnXZAxis: (mesh, amount)->
      mesh.position.x += amount
      mesh.position.z += amount

    changeSize: (mesh, amount)->
      mesh.scale.x += amount
      mesh.scale.y += amount
      mesh.scale.z += amount

    lineFactory: (array, type)->
      for i in [3...7]
        if type is 'track' then size = i * .6
        if type is 'planet' then size = .28

        radiusTop       =  size
        radiusBottom    =  size
        height          =  0.002
        radiusSegments  =  32
        heightSegments  =  1
        openEnded       =  false
        thetaStart      =  0 # Start angle for first segment, default = 0 (three o'clock position).
        # thetaLength     =  The central angle, often called theta, of the circular sector. The default is 2*Pi, which makes for a complete cylinder.

        lineGeo = new THREE.CylinderGeometry( radiusTop,radiusBottom,height,radiusSegments,heightSegments,openEnded,thetaStart )
        lineMat = new THREE.LineBasicMaterial({
          color: 0xffffff
          transparent: true
        })
        lineGeo.vertices.pop()
        lineGeo.vertices.pop()
        solarLine = new THREE.Line( lineGeo, lineMat )

        if type is 'track'
          solarLine.rotation.x += .4
          solarLine.rotation.y += i * 1.5
        if type is 'planet'
          solarLine.rotation.x += 1.5
        array.push(solarLine)


</script>

<style lang="sass">
@import src/styles/main

#three
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  overflow: hidden

  .buttons
    position: absolute
    top: 20px




</style>
