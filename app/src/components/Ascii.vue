<template>
  <div id="ascii"></div>
</template>

<script lang="coffee">
THREE = require 'three'
# { EffectComposer, RenderPass, FilmPass } = require 'postprocessing'

module.exports =
  name: 'ascii'

  mounted: ->
    HEIGHT = @$el.offsetHeight
    WIDTH = @$el.offsetWidth

    # set up scene and camera
    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera( 75, WIDTH / HEIGHT, 0.1, 1000 )
    camera.position.z = 2

    # web gl renderer, appended to component body
    renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
    renderer.setSize( WIDTH, HEIGHT )
    renderer.shadowMap.enabled = true
    @$el.appendChild( renderer.domElement )


    # add geometry
    geometry = new THREE.OctahedronGeometry(1, 1)
    material = new THREE.MeshBasicMaterial({
      color: 0x0b3039
      wireframe: true
    })

    # mesh takes a geometry and adds a material
    @cube = new THREE.Mesh( geometry, material )
    @cube.receiveShadow = true
    scene.add( @cube )

    # lighting
    hemisphereLight = new THREE.HemisphereLight(0xb98a5b,0x000000, .9)
    shadowLight = new THREE.DirectionalLight(0xb98a5b, .9)
    shadowLight.position.set(5, 5, 10)
    shadowLight.castShadow = true
    scene.add( hemisphereLight )
    scene.add( shadowLight )

    # render recursively
    do render = ()=>
      @changeRotation()
      requestAnimationFrame( render )
      renderer.render( scene, camera )

  methods:
    changeRotation: ()->
      @cube.rotation.x += 0.005
      @cube.rotation.y += 0.005
    changeSize: ()->
      @cube.scale.x += 0.1
      @cube.scale.y += 0.1
      @cube.scale.z += 0.1


</script>

<style lang="sass">
@import src/styles/main

#ascii
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  overflow: hidden
  height: 100%

  .buttons
    position: absolute
    top: 20px




</style>
