<template>
  <div id="our-services">

    <div class="header-container">

      <div class="title-container">
        <div class="title">Our Services</div>
        <div class="link-container">
          <div class="link">About Us</div>
          <div class="link">Contact Us</div>
        </div>
      </div>

      <div class="introduction-container">
        <div class="before-bar"></div>
        <div class="introduction">
          Hotmax offers a broad range of services to clients interested in bringing their
          interactive ideas to life. With our skills in web-based application development,
          exploratory technologies like AR and VR, and user-interface and sound design,
          we’re well equipped to take complex projects from concept to reality.
        </div>
      </div>

    </div>


    <div class="service-panel">
      <div class="icon strategy">
        <div class="left"></div>
        <div class="right"></div>
      </div>
      <div class="panel-text">
        <div class="title">Interactive Strategy</div>
        <div class="text">
          We make dope shit. You should hire us fools.
        </div>
      </div>
    </div>

    <div class="service-panel">
      <div class="icon design">
        <div id="model-window"></div>
      </div>
      <div class="panel-text">
        <div class="title">Digital Design</div>
        <div class="text">
          We design dope shit, you should hire us fools.
        </div>
      </div>
    </div>

    <div class="service-panel">
      <div class="icon development"></div>
      <div class="panel-text">
        <div class="title">AR + VR Development</div>
        <div class="text">
          We do stuff in AR and VR, you should hire us fools.
        </div>
      </div>
    </div>


    <div class="service-panel">
      <div class="icon"></div>
      <div class="panel-text">
        <div class="title">Contact Us</div>
        <div class="text">
          Give us a jingle ringle. Preferably in our pants.
        </div>
      </div>
    </div>


  </div>
</template>

<script lang="coffee">
PIXI = require 'pixi.js'
logoImg = require '../assets/logo-triangle.png'

module.exports =
  name: 'ourServices'
  data: ->
    positionalData: null

  destroyed: ->
    @app.destroy()

  mounted: ->

    windowModel = document.getElementById('model-window')
    @app = new PIXI.Application(windowModel.offsetWidth, windowModel.offsetHeight, {antialias: true, transparent: true, resolution: 1})
    windowModel.appendChild(@app.view)
    PIXI.settings.SCALE_MODE = PIXI.SCALE_MODES.NEAREST

    #make header
    graphic = new PIXI.Graphics()
    graphic.lineStyle(2, 0x000000, 1)
    graphic.drawRect(10, 10, @app.renderer.width - 20, 20)
    @app.stage.addChild(graphic);

    #make panels
    for i in [0...3]
      graphic.lineStyle(2, 0x000000, 1)
      graphic.drawRect(
        10 + (i * (@app.renderer.width / 4)),
        (@app.renderer.height - 50) / 2,
        @app.renderer.width / 4,
        @app.renderer.height / 2.5
      )
      graphic.hitArea = graphic.getBounds()
      @app.stage.addChild(graphic);
    graphic.interactive = true
    graphic.buttonMode = true


    # make sprite and position it
    # logo = PIXI.Sprite.fromImage(logoImg)
    # logo.position.set(@app.renderer.width / 2, @app.renderer.height / 2)
    # logo.scale.set(0.5,0.5)
    # logo.anchor.set(0.5,0.5)
    # @app.stage.addChild(logo);

    #filters
    # blurFilter = new PIXI.filters.BlurFilter()
    # logo.filters = [blurFilter]

    @app.ticker.add (delta)=>
      # logo.rotation += 0.05 / delta


    graphic.on 'pointerdown', (e)=>
      @positionalData = e.data
      graphic.alpha = 0.5
      @dragging = true
    graphic.on 'pointerup', ()=>
      graphic.alpha = 1
      @dragging = false
      @positionalData = null
    graphic.on 'pointerupoutside', ()=>
      graphic.alpha = 1
      @dragging = false
      @positionalData = null
    graphic.on 'pointermove', ()=>
      if @dragging
        newPosition = @positionalData.getLocalPosition(graphic.parent)
        graphic.x = newPosition.x
        graphic.y = newPosition.y

</script>

<style lang="sass">
@import src/styles/main

#our-services
  .icon
    width: auto
    &.strategy
      +flexbox
      +align-items(center)
      height: 200px
      .left
        height: 100%
        +flex(1 1 70%)
        background-position: 0% 0%
        background-size: contain
        background-repeat: no-repeat
        background-image: url('../assets/strategy-icon.svg')
      .right
        border: 5px solid white
        padding: 5px
        margin-left: -50px
        height: 90%
        position: relative
        +flex(1 1 40%)
        background-position: 50% 0%
        background-size: auto 100%
        background-repeat: no-repeat
        background-image: url('../assets/flower-bloom.gif')
        &::after
          content: ''
          position: absolute
          top: -5px
          left: -5px
          width: calc(100% + 10px)
          height: calc(100% + 10px)
          border: 2px solid black

    &.design
      height: 16vw
      width: 100%
      border: 2px solid black
      padding: 15px
      position: relative
      #model-window
        height: 100%
        border: 2px solid black
      &::after
        position: absolute
        display: block
        border: 2px solid black
        content: ''
        width: 100px
        height: 20px
        bottom: -20px
        left: 50%
        +translateXY(-50%, 0)
      &::before
        position: absolute
        display: block
        border: 2px solid black
        content: ''
        width: 10px
        height: 10px
        bottom: 2px
        border-radius: 100%
        left: 50%
        +translateXY(-50%, 0)

    &.development
      height: 16vw
      width: 100%
      border: 2px solid black
      position: relative
      &::after
        position: absolute
        display: block
        content: ''
        width: 100%
        height: 100%
        background-position: 50% 0%
        background-size: auto 120%
        background-repeat: no-repeat
        background-image: url('../assets/vr-icon.svg')

</style>
