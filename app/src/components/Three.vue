<template>
  <div id="three"></div>
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

  .camera-stuff
    position: absolute
    top: 100px
    right: 100px
</style>

<script lang="coffee">
THREE = require 'three'
Stats = require 'stats.js'
_ = require 'lodash'
{ TweenLite } = require 'gsap'
{ EffectComposer, BloomPass, RenderPass, FilmPass, GlitchPass } = require 'postprocessing'

module.exports =
  name: 'three'
  props:
    mode:   type: String
    glitch: type: Boolean
    sound:  type: Boolean

  data: ->
    rotationalParents: []
    orbitTracks: []
    planetParents: []
    planets: []
    sunRayCast: false

  mounted: ->
    # set up scene and camera
    scene = new THREE.Scene()
    @HEIGHT = window.innerHeight
    @WIDTH = window.innerWidth

    stats = new Stats()
    stats.showPanel( 1 ) #0: fps, 1: ms, 2: mb, 3+: custom
    document.body.appendChild( stats.dom )

    # window.addEventListener('resize', handleWindowResize, false) # update the camera and the renderer size on window resize

    @camera = new THREE.PerspectiveCamera( 75, @WIDTH / @HEIGHT, 1, 1000 )
    @camera.position.z = 5

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
    @sunMesh.name = 'sun'
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
    composer1.addPass(new RenderPass( scene, @camera ))
    composer2 = new EffectComposer(renderer)
    composer2.addPass(new RenderPass( scene, @camera ))
    composer3 = new EffectComposer(renderer)
    composer3.addPass(new RenderPass( scene, @camera ))

    filmPass = new FilmPass({     # film pass -- used for entry
      noiseIntensity:     0.5
      scanlineIntensity:  0.4
      scanlineDensity:    1.2
      vignette:           true
      vignetteOffset:     0.5
      vignetteDarkness:   0.75
    })
    glitchPass = new GlitchPass() # glitch pass and default mode -- used for transition
    glitchPass.mode = .5
    bloomPass = new BloomPass({   # bloom pass -- used for desktop
      resolution:  0.5
      blurriness:  1.0
      strength:    1.1
      distinction: -0.75
    })
    bloomPass.renderToScreen  = false    # rendering options
    glitchPass.renderToScreen = false
    filmPass.renderToScreen   = true

    composer1.addPass(filmPass)
    composer2.addPass(glitchPass)
    composer3.addPass(bloomPass)
    clock = new THREE.Clock()   # clock needed for pass

    mouse = new THREE.Vector2() #mouse position
    window.addEventListener 'mousemove', (e)=>
      mouse.x = ( event.clientX / @WIDTH ) * 2 - 1
      mouse.y = - ( event.clientY / @HEIGHT ) * 2 + 1
    , false

    raycaster = new THREE.Raycaster()


    # change pass on desktop mode change
    # @$watch 'mode', (mode)=>
    #   if mode is 'desktop'
    #     bloomPass.renderToScreen  = true
    #     filmPass.renderToScreen   = false

    @$watch 'glitch', (mode)=>
      if mode is true
        glitchPass.renderToScreen = true
        bloomPass.renderToScreen  = false
      else
        glitchPass.renderToScreen = false
        bloomPass.renderToScreen  = true


    #watch for sun hit and do something
    @$watch 'sunRayCast', (mode)=>
      if mode is true
        console.log 'sun has been hit'
        console.log @sunMesh

        # TweenLite.to( @sunMesh.rotation, 2, {
        #   y: -Math.PI
        #   ease: Bounce.easeOut
        # })

      else
        console.log 'sun is not being hit'


    # //////////////////////////////////////////
    #  R E N D E R   L O O P
    # /////////////////////////////////////////
    do render = ()=>
      delta = clock.getDelta()
      time = clock.getElapsedTime()

      stats.begin()

      # on desktop flag -> animate new position and track mouse position
      if @mode is 'desktop'
        @camera.position.z += .05  if @camera.position.z <= 12.5
        @camera.rotation.z -= .01  if @camera.rotation.z >= -1.5
        @map.rotation.x    += .01  if @map.rotation.x <= 1.55

        @orbitTracks[0].rotation.z = mouse.y * 0.3
        @orbitTracks[0].rotation.x = mouse.x * 0.3
        @orbitTracks[1].rotation.z = -mouse.y * 0.15
        @orbitTracks[1].rotation.x = -mouse.x * 0.15
        @orbitTracks[2].rotation.z = mouse.y * 0.15
        @orbitTracks[2].rotation.x = mouse.x * 0.15
        @orbitTracks[3].rotation.z = -mouse.y * 0.15
        @orbitTracks[3].rotation.x = -mouse.x * 0.15


      #raycasting watcher
      raycaster.setFromCamera( mouse, @camera )
      intersects = raycaster.intersectObjects( @map.children )
      if intersects.length > 0
        names = intersects.map (intersect)-> intersect.object.name
        if _.includes(names, 'sun') then @sunRayCast = true else @sunRayCast = false


      # rotation of orbit tracks and sun
      for line,i in @orbitTracks
        @rotateOnOneAxis(line, delta/3, 'y')
      @rotateOnXYAxis(@sunMesh, delta/2)

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

      stats.end()

      requestAnimationFrame(render)
      composer1.render(delta)
      composer2.render(delta)
      composer3.render(delta)


  methods:
    runSunSound: _.throttle ()->
      if @sound
        audio = new Audio("/static/wavs/orbitTracks/planetTrack1.wav");
        audio.play()
    , 250

    runLineSound: _.throttle (object)->
      id = object.id
      trackNumber = switch
        when id is 16 then '1'
        when id is 15 then '2'
        when id is 14 then '3'
        when id is 13 then '4'
      if trackNumber && @sound
        audio = new Audio("/static/wavs/orbitTracks/planetTrack#{trackNumber}.wav");
        audio.play()
    , 125

    # rotational stuff
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
