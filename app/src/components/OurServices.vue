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
          Hotmax offers consulting and development services to organizations interested in bringing their
          interactive ideas to life. With our skills in web-based application development,
          exploratory technologies like AR and VR, and user-interface and sound design,
          we’re well equipped to take complex projects from concept to reality.
        </div>
      </div>

    </div>


    <div class="service-panel reverse">
      <div class="icon strategy">
        <div class="left"></div>
        <div class="right"></div>
      </div>
      <div class="panel-text">
        <div class="title">Interactive Strategy</div>
        <div class="text">
          We consult with your organization to find stategies that will allow you to fully take advantage of available interactive tools and technologies.
        </div>
      </div>
    </div>

    <div class="service-panel">
      <div class="icon design">
        <transition name="fadedown">
          <div class="tooltip" v-if="showToolTip">Enjoy DESIGN SIMULATOR v1.01!</div>
        </transition>
        <div id="model-window">
          <div class="toolpanel">
            <div class="tool brush"></div>
            <div class="tool eraser" @click="eraseWork"></div>
          </div>
        </div>
      </div>
      <div class="panel-text">
        <div class="title">Digital Design</div>
        <div class="text">
          We handcraft the software that your organization needs to succeed in the interactive space.
          <br>
          We're a full stack agency — we build the underlying systems all the way to the user-experience and interface.
        </div>
      </div>
    </div>

    <div class="service-panel reverse">
      <div class="icon development">
        <div id="vr-window"></div>
      </div>
      <div class="panel-text">
        <div class="title">AR + VR Development</div>
        <div class="text">
          We're exploring the implications of Augmented and Virtual Reality in different industries.
          <br>
          We work with your organization to see how these technologies could expand your reach to clients, or add benefits to software you already use.
        </div>
      </div>
    </div>


    <div class="service-panel centered contact">
      <div class="panel-text">
        <div class="title">Contact Us</div>
        <div class="text">
          Does it sound like we could help your organization?
          <div class="contact-link">Drop us a line</div>
        </div>
      </div>
    </div>


  </div>
</template>

<script lang="coffee">
PIXI = require 'pixi.js'
filters = require 'pixi-filters'

logoImg = require '../assets/logo-triangle.png'

module.exports =
  name: 'ourServices'
  data: ->
    positionalData: null
    showToolTip: true

  destroyed: ->
    @app.destroy()
    @vrApp.destroy()

  methods:
    eraseWork: ->
      while @app.stage.children[0]
        @app.stage.removeChild @app.stage.children[0]

    createPixel: (pos)->
      @showToolTip = false
      graphic = new PIXI.Graphics()
      graphic.beginFill(0x000000)
      graphic.drawCircle(pos.x, pos.y, 3)
      graphic.endFill(0x000000)
      @app.stage.addChild(graphic)

  mounted: ->
    PIXI.settings.SCALE_MODE = PIXI.SCALE_MODES.NEAREST

    #drawing computer
    windowModel = document.getElementById('model-window')
    @app = new PIXI.Application(windowModel.offsetWidth, windowModel.offsetHeight, {antialias: true, transparent: true, resolution: 1})
    windowModel.appendChild(@app.view)
    @app.stage.interactive = true

    #vr space
    vrModel = document.getElementById('vr-window')
    @vrApp = new PIXI.Application(vrModel.offsetWidth, vrModel.offsetHeight, {antialias: true, transparent: true, resolution: 1})
    vrModel.appendChild(@vrApp.view)
    # @vrApp.stage.interactive = true

    #brush
    @app.renderer.plugins.interaction.on 'mousedown', (e)=>
      @brushDrag = true
      @createPixel(e.data.global)
    @app.renderer.plugins.interaction.on 'mouseup', (e)=>
      @brushDrag = false
    @app.renderer.plugins.interaction.on 'mousemove', (e)=>
      if @brushDrag
        @createPixel(e.data.global)

    #brush on mobile
    @app.renderer.plugins.interaction.on 'touchstart', (e)=>
      @brushDrag = true
      @createPixel(e.data.global)
    @app.renderer.plugins.interaction.on 'touchend', (e)=>
      @brushDrag = false
    @app.renderer.plugins.interaction.on 'touchmove', (e)=>
      if @brushDrag
        @createPixel(e.data.global)



    #filters
    asciiFilter = new PIXI.filters.RGBSplitFilter()
    @vrApp.stage.filters = [asciiFilter]

    # make sprite and position it
    logo = PIXI.Sprite.fromImage(logoImg)
    logo.position.set(@app.renderer.width / 2, @app.renderer.height / 2)
    logo.scale.set(0.5,0.5)
    logo.anchor.set(0.5,0.5)
    logo.interactive = true
    @vrApp.stage.addChild(logo)

    count = 0
    @vrApp.ticker.add (delta)=>
      count += 0.1
      logo.scale.x = 1 + Math.sin(count) * 0.04
      logo.scale.y = 1 + Math.cos(count) * 0.04



    #drag the object
    # logo.on 'pointerdown', (e)=>
    #   console.log 'yeah'
    #   @positionalData = e.data
    #   logo.alpha = 0.5
    #   @dragging = true
    # logo.on 'pointerup', ()=>
    #   logo.alpha = 1
    #   @dragging = false
    #   @positionalData = null
    # logo.on 'pointerupoutside', ()=>
    #   logo.alpha = 1
    #   @dragging = false
    #   @positionalData = null
    # logo.on 'pointermove', (e)=>
    #   e.data.originalEvent.preventDefault()
    #   if @dragging
    #     newPosition = @positionalData.getLocalPosition(logo.parent)
    #     logo.x = newPosition.x
    #     logo.y = newPosition.y


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
      .tooltip
        position: absolute
        top: -50px
        left: 15px
        width: calc(100% - 30px)
        background-color: $action_red
        padding: 5px
        color: white
        text-align: center
        z-index: 9
        font-size: 13px
        &::before
          content: ''
          width: 20px
          height: 20px
          background-color: $action_red
          position: absolute
          bottom: -3px
          left: 50%
          transform: translate(-50%, 0) rotate(45deg)
          z-index: -1
      #model-window
        height: 100%
        border: 2px solid black
        cursor: pointer
        // background-color: #5092e4

        .toolpanel
          position: absolute
          left: 30px
          top: 40px
          +flexbox
          +flex-direction(row)
          padding: 5px
          border: 2px solid black
          &::after
            content: ''
            position: absolute
            top: -10px
            left: -2px
            height: 10px
            width: calc(100% + 4px)
            border: 2px solid black
          &::before
            content: ''
            position: absolute
            top: -6px
            left: 6px
            height: 3px
            width: 3px
            background-color: black
          .tool
            border: 2px solid black
            width: 30px
            height: 30px
            display: inline-block
            +clickable
            &:first-of-type
              border-right: 0
            &.brush
              background-position: 50% 50%
              background-size: 100% 100%
              background-repeat: no-repeat
              background-image: url('../assets/brush.svg')
            &.eraser
              background-position: 50% 50%
              background-size: 100% 100%
              background-repeat: no-repeat
              background-image: url('../assets/eraser.svg')
              +transition(.15s ease all)
              &:hover
                background-color: $action_red
                +transition(.15s ease all)


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
      #vr-window
        width: 100%
        height: 100%
        position: absolute
        left: 0
        top: 0
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
