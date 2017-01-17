<template>
  <div id="asteroids">
    <div class="user-interface">
      <div class="score">Score: {{score}}</div>
      <div class="lives">
        <span class="live-title">Lives:</span>
        <span class="live-hearts" v-for='live in 4'></span>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
THREE = require 'three'
_ = require 'lodash'
{ EffectComposer, BloomPass, RenderPass } = require 'postprocessing'

module.exports =
  name: 'asteroids'

  data: ->
    score: 0
    lives: 4
    showExhaust: false
    asteroidCollection: []
    bulletCollection: []
    keyPressMap:
      KeyA: false
      KeyS: false
      KeyD: false
      KeyW: false
      Space: false

  mounted: ->
    scene = new THREE.Scene()
    @HEIGHT = @$el.offsetHeight
    @WIDTH = @$el.offsetWidth

    # update the camera and the renderer size on window resize
    # window.addEventListener('resize', handleWindowResize, false)

    # camera
    # camera = new THREE.PerspectiveCamera( 75, WIDTH / HEIGHT, 0.1, 1000 )
    camera = new THREE.OrthographicCamera( @WIDTH / - 2, @WIDTH / 2, @HEIGHT / 2, @HEIGHT / - 2, 1, 2000 )
    camera.position.z = 1000

    # web gl renderer, appended to component body
    renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
    renderer.setSize( @WIDTH, @HEIGHT )
    renderer.shadowMap.enabled = true
    @$el.appendChild( renderer.domElement )

    # initialize map object (celestial parent)
    @map = new THREE.Object3D()
    scene.add(@map)

    # add spaceship
    spaceshipGeo = new THREE.ConeGeometry( 10,30,5 )
    spaceshipMat = new THREE.MeshPhongMaterial({
      color: 0xffffff
      transparent: true
      shininess: 10
      specular: 0xffffff
      shading: THREE.FlatShading
      # wireframe: true
    })
    @spaceship = new THREE.Mesh( spaceshipGeo, spaceshipMat )
    @spaceship.receiveShadow = true
    @shipMomentum = new THREE.Vector3(0,0,0)

    @map.add( @spaceship )

    # add asteroids
    for i in [0..1]
      @asteroidBuilder()

    # fog??
    scene.fog = new THREE.Fog(0xf7d9aa, 100,950)

    # lighting
    hemisphereLight = new THREE.HemisphereLight(0xb98a5b,0x000000, .9)
    shadowLight = new THREE.DirectionalLight(0xb98a5b, .9)
    shadowLight.position.set(5, 5, 10)
    shadowLight.castShadow = true
    scene.add( hemisphereLight )
    scene.add( shadowLight )

    # set up effect composer and then pass
    composer = new EffectComposer(renderer)
    composer.addPass(new RenderPass( scene, camera ))
    bloomPass = new BloomPass({
      resolution:  0.5
      blurriness:  1.0
      strength:    1.1
      distinction: -0.75
    })
    bloomPass.renderToScreen  = true
    composer.addPass(bloomPass)


    # begin raycasting
    mouse = new THREE.Vector2()
    raycaster = new THREE.Raycaster()
    window.addEventListener 'mousemove', (e)=>
      mouse.x = ( event.clientX / @WIDTH ) * 2 - 1
      mouse.y = - ( event.clientY / @HEIGHT ) * 2 + 1
    , false
    mousePoint = new THREE.Vector3()

    # handle keybindings
    window.addEventListener 'keydown', (e)=>
      @keyPressMap[e.code] = true
      if e.code is 'Space' then @bulletBuilder() #handle seperately from other keycodes
    , false
    window.addEventListener 'keyup', (e)=>
      @keyPressMap[e.code] = false
    , false


    # this is needed for the pass for some reason
    clock = new THREE.Clock()

    # ///////////////////////////////////
    #      R E N D E R   L O O P
    # //////////////////////////////////
    do render = ()=>
      @delta = clock.getDelta()
      @time = clock.getElapsedTime()

      #update the picking ray with the camera and mouse position
      raycaster.setFromCamera( mouse, camera )
      intersects = raycaster.intersectObjects( @map.children )
      # if intersects.length > 0
      #   #intersects[0].object?
      #   # do something
      # else
      #   # do something else

      #handle ship momentum
      tempMomentum = new THREE.Vector3()
      tempMomentum.copy(@shipMomentum)
      tempMomentum.multiplyScalar(50 * @delta)

      @spaceship.position.add(tempMomentum)


      @handleKeyBindings()      # handle spaceship logic
      @handleBounds(@spaceship)

      for asteroid in @asteroidCollection # handle asteroid logic
        asteroid.position.x += 1
        asteroid.position.y += 1
        @handleBounds(asteroid)

      for bullet in @bulletCollection # handle bullet logic
        bullet.position.y += 1
        bullet.position.x += 1
        @handleBounds(bullet)

      requestAnimationFrame(render)
      composer.render(@delta)


  methods:
    changePosition: (mesh, amount, axis)->
      mesh.position[axis] = amount

    changeSize: (mesh, amount)->
      mesh.scale.x += amount
      mesh.scale.y += amount

    handleBounds: (obj)->
      if obj.position.x < @WIDTH / -2
        obj.position.x = @WIDTH / 2
      if obj.position.x > @WIDTH / 2
        obj.position.x = @WIDTH / -2
      if obj.position.y < @HEIGHT / -2
        obj.position.y = @HEIGHT / 2
      if obj.position.y > @HEIGHT / 2
        obj.position.y = @HEIGHT / -2

    handleKeyBindings: ->
      if @keyPressMap.KeyA is true    #A - left
        @spaceship.rotation.z -= .1

      if @keyPressMap.KeyD is true    #D - right
        @spaceship.rotation.z += .1

      if @keyPressMap.KeyW is true    #W - forward accel
        @shipThrust()

      if @keyPressMap.KeyS is true    #S - back accel
        @spaceship.position.y -= 1

    shipThrust: ->
      forwardVector = new THREE.Vector3(0, 10 * @delta, 0)
      rotationMatrix = new THREE.Matrix4()
      rotationMatrix.makeRotationFromEuler(@spaceship.rotation)
      forwardVector.applyMatrix4(rotationMatrix)
      @shipMomentum.add(forwardVector)

      if @shipMomentum.x > 5  then @shipMomentum.x = 5
      if @shipMomentum.x < -5 then @shipMomentum.x = -5
      if @shipMomentum.y > 5  then @shipMomentum.y = 5
      if @shipMomentum.y < -5 then @shipMomentum.y = -5
      # @spaceship.position.add(forwardVector)

      @showExhaust = true;


    asteroidBuilder: ->
      radiusBuilder   = Math.floor(Math.random()*(60-20+1)+20)
      radiusTop       = radiusBuilder
      radiusBottom    = radiusBuilder
      height          = 0.002
      radiusSegments  = 9
      heightSegments  = 1
      openEnded       = false
      thetaStart      = 0 # Start angle for first segment, default = 0 (three o'clock position).
      # thetaLength   =     The central angle, often called theta, of the circular sector. The default is 2*Pi, which makes for a complete cylinder.
      lineGeo = new THREE.CylinderGeometry( radiusTop,radiusBottom,height,radiusSegments,heightSegments,openEnded,thetaStart )
      lineMat = new THREE.LineBasicMaterial({
        color: 0xffffff
        transparent: true
      })
      lineGeo.vertices.pop()
      lineGeo.vertices.pop()
      asteroid = new THREE.Line( lineGeo, lineMat )
      asteroid.rotateX(90)
      asteroid.rotateY(Math.random()*10)
      asteroid.position.x = Math.floor(Math.random()*500) - 250
      asteroid.position.z = Math.floor(Math.random()*500) - 250
      @asteroidCollection.push(asteroid)
      @map.add(asteroid)

    bulletBuilder: _.throttle ->
      width   =  20
      height  =  1
      bulletGeo = new THREE.PlaneGeometry( width, height)
      bulletMat = new THREE.MeshBasicMaterial({
        color: 0xb98a5b
        side: THREE.DoubleSide
      })
      bullet = new THREE.Line( bulletGeo, bulletMat )
      bullet.position.copy(@spaceship.position) # set bullet from where spaceship is

      bullet.rotateZ(@spaceship.rotation.z)
      console.log bullet.rotation.z, @spaceship.rotation.z

      @move = ()=>
        movement = new THREE.Vector3(0,10,0)
        m = new THREE.Matrix4()
        m.makeRotationFromEuler(bullet.rotation)
        movement.applyMatrix4(m)
        bullet.position.add(movement)
        # check to see if we went pass viewport bounds
        if bullet.position.x < @WIDTH / -2
          bullet.position.x = @WIDTH / 2
        if bullet.position.x > @WIDTH / 2
          bullet.position.x = @WIDTH / -2
        if bullet.position.y < @HEIGHT / -2
          bullet.position.y = @HEIGHT / 2
        if bullet.position.y > @HEIGHT / 2
          bullet.position.y = @HEIGHT / -2

      #create bullet and then set timeout and destroy and pop bullet from array
      @bulletCollection.push(bullet)
      @map.add(bullet)


    , 500

</script>

<style lang="sass">
@import src/styles/main
#asteroids
  cursor: default
  background-color: $ink_black
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  overflow: hidden
  border: 2px solid white
  .user-interface
    position: absolute
    text-transform: uppercase
    letter-spacing: 2px
    font-size: 15px
    padding: 20px
    width: 100%
    top: 0
    left: 0
    color: white
    +justify-content(space-between)
    +flexbox
    +align-items(center)
    .lives
      +flexbox
      +align-items(center)
      width: 200px
      .live-hearts
        display: inline-block
        width: 25px
        height: 25px
        border-radius: 100%
        margin-left: 10px
        border: 1px solid white
</style>
