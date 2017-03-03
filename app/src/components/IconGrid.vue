<template>
  <div id="icon-grid">

    <div class="icon-group">

      <div @click="openPortfolio" class="icon folder" :class="{new : showNew}">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Hotmax Work</div>
      </div>
      <div @click="openOverlay(consoleTexts.contactUs)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">Contact Us</div>
      </div>

    </div>
    <div class="icon-group">

      <div @click="openOverlay(consoleTexts.aboutUs)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">About Us</div>
      </div>
      <div @click="openOverlay(consoleTexts.ourServices)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">Our Services</div>
      </div>

    </div>
    <!-- <div class="icon-group float-group" v-if="port != 'mobile'">

      <div @click="openNavigatorWindow(navigatorWindows.rubbish)" class="icon rubbish">
        <img src="../assets/rubbish-icon.svg">
        <div class="caption">Rubbish Bin</div>
      </div>

    </div> -->
  </div>
</template>

<script lang="coffee">
interact = require('interact.js')
folderIcon = require '../assets/folder-icon.svg'


module.exports =
  name: 'projectsPanel'

  methods:
    openPortfolio: ()->
      @showNew = false
      @$store.dispatch 'openPortfolio'

    openOverlay: (view)->
      overlay = view
      overlay.orientation = 'portrait'
      @$store.dispatch 'openServicesOverlay', view

    openNavigatorWindow: (view)->
      @$store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_NAVIGATOR_WINDOW', view


  computed:
    #vuex state
    navigatorWindows: ->  return @$store.state.navigatorWindows
    consoleTexts: ->      return @$store.state.consoleTexts
    port: ->              return @$store.state.port

  data: ->
    positionalData: null
    showNew: true

  # mounted: ->
  #   iconGrid = document.getElementById('icon-grid')
  #   @app = new PIXI.Application(iconGrid.offsetWidth, iconGrid.offsetHeight, {antialias: true, transparent: true, resolution: 1})
  #   iconGrid.appendChild(@app.view)
  #   PIXI.settings.SCALE_MODE = PIXI.SCALE_MODES.NEAREST
  #
  #   # make sprite and position it
  #   folder = PIXI.Sprite.fromImage(folderIcon)
  #   folder.position.set(@app.renderer.width / 2, @app.renderer.height / 2)
  #   folder.scale.set(0.5,0.5)
  #   folder.anchor.set(0.5,0.5)
  #
  #   folder.interactive = true
  #   folder.buttonMode = true
  #   @app.stage.addChild(folder);
  #
  #   #filters
  #   # blurFilter = new PIXI.filters.BlurFilter()
  #   # folder.filters = [blurFilter]
  #
  #   @app.ticker.add (delta)=>
  #     # folder.rotation += 0.05 / delta
  #
  #
  #   folder.on 'pointerdown', (e)=>
  #     @positionalData = e.data
  #     folder.alpha = 0.5
  #     @dragging = true
  #   folder.on 'pointerup', ()=>
  #     folder.alpha = 1
  #     @dragging = false
  #     @positionalData = null
  #   folder.on 'pointerupoutside', ()=>
  #     graphic.alpha = 1
  #     @dragging = false
  #     @positionalData = null
  #   folder.on 'pointermove', ()=>
  #     if @dragging
  #       newPosition = @positionalData.getLocalPosition(folder.parent)
  #       folder.x = newPosition.x
  #       folder.y = newPosition.y



</script>

<style lang="sass">
@import src/styles/main

#icon-grid
  padding-left: 40px
  align-self: flex-start
  width: 90%
  height: 80%
  +transition(.35s ease all)
  z-index: 99
  position: absolute

  .icon-group
    width: 100%
    +flexbox
    +align-content(row)
    +align-items(flex-end)
    margin-bottom: 30px
    +screen(mobile)
      +justify-content(space-around)
    &.float-group
      position: absolute
      margin-bottom: 0
      bottom: 0

    .icon
      +clickable
      margin-right: 30px
      .caption
        padding: 5px 0 0 10px
        +systemType
        color: $ink_black
        letter-spacing: 1px
      &.rubbish
        width: 77px
      &.folder
        width: 85px
      &.file
        width: 60px
        margin-right: 55px

      &.new::before
        content: '!'
        +consoleType(normal)
        +flexbox
        +align-items(center)
        +justify-content(center)
        text-align: center
        color: white
        height: 25px
        width: 25px
        border-radius: 100%
        display: block
        position: absolute
        top: 5px
        left: 25px
        z-index: 999
        background-color: $action_red
        +transition(.35s ease all)
        +screen(mobile)
          display: none


</style>
