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

    console.log @$el.offsetWidth, @$el.offsetHeight

    # set up scene and camera
    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera( 75, WIDTH / HEIGHT, 0.1, 1000 )
    camera.position.z = 5

    # web gl renderer, appended to component body
    renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true })
    renderer.setSize( WIDTH, HEIGHT )
    renderer.shadowMap.enabled = true
    @$el.appendChild( renderer.domElement )

    # effect = new THREE.AsciiEffect( renderer )
    # effect.setSize( width, height )
    # container.appendChild( effect.domElement )

    # add geometry
    geometry = new THREE.TetrahedronGeometry( 1,3 )
    material = new THREE.MeshPhongMaterial({
      color: 0xef5e6c
      shininess: 10
      specular: 0xffffff
      shading: THREE.FlatShading
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
      @cube.rotation.x += 0.01
      @cube.rotation.y += 0.01
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
