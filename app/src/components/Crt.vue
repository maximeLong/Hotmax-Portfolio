<template>
  <div id="crt">
    
  </div>
</template>

<script lang="coffee">
THREE = require 'three'
{ EffectComposer, RenderPass, FilmPass } = require 'postprocessing'

module.exports =
  name: 'crt'

  mounted: ->

    # height and width
    HEIGHT = window.innerHeight
    WIDTH = window.innerWidth

    # web gl renderer, appended to component body
    renderer = new THREE.WebGLRenderer({premultipliedAlpha: false})
    renderer.setSize( WIDTH, HEIGHT )
    @$el.appendChild( renderer.domElement )

    # set up scene and camera
    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera( 75, WIDTH / HEIGHT, 0.1, 1000 )
    camera.position.z = 40

    # fog??
    # scene.fog = new THREE.Fog( 0x000000, 1, 1000 )

    # lighting
    hemisphereLight = new THREE.HemisphereLight(0xb98a5b,0x000000, .9)
    shadowLight = new THREE.DirectionalLight(0xffffff, .5)
    shadowLight.position.set(0, 0, 10)
    shadowLight.castShadow = true
    scene.add( hemisphereLight )
    scene.add( shadowLight )

    # add geometry
    geometry = new THREE.PlaneGeometry( WIDTH, HEIGHT )
    material = new THREE.MeshBasicMaterial({
      color: 0xffffff
      # shininess: 5
      # specular: 0xffffff
      # shading: THREE.FlatShading
    })
    material.opacity   = 0;
    material.blending  = THREE.NoBlending;
    @plane = new THREE.Mesh( geometry, material )
    @plane.receiveShadow = true
    scene.add( @plane )

    # set up effect composer and then pass
    composer = new EffectComposer(renderer)
    composer.addPass(new RenderPass( scene, camera ))

    # film pass
    pass = new FilmPass({
      noiseIntensity: .15
      scanlineIntensity: .4
      scanlineDensity: 1.2
      vignette: true
      vignetteOffset: .5
      vignetteDarkness: .75
    })
    pass.renderToScreen = true
    composer.addPass(pass)

    # this is needed for the pass for some reason
    clock = new THREE.Clock()

    # render recursively
    do render = ->
      requestAnimationFrame(render)
      delta = clock.getDelta()
      composer.render(delta)
      # renderer.render( scene, camera )


</script>

<style lang="sass">
@import src/styles/main

#crt
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
