<template>
  <transition appear name="fade">
  <div id="projects-panel">

    <!-- portfolio window -->
    <div class="window-container projectWindow" v-if="projectWindowIsOpen || portfolioWindowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::Portfolio' + additionalTitle"
        :type="portfolioWindowIsOpen ? 'portfolio' : 'project'"
        :toggleContainer="portfolioWindowIsOpen ? true : false">

        <transition name="fadeup">
          <portfolio v-if="portfolioWindowIsOpen"></portfolio>
        </transition>
        <component v-bind:is="activeProjectWindow.content" v-if="projectWindowIsOpen"></component>

      </window>
    </div>

    <!-- navigator window, use for small navigations -->
    <div class="window-container navigator" :class="activeNavigatorWindow.content" v-if="navigatorWindowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::' + activeNavigatorWindow.shortTitle"
        :type="'navigator'">
        <component v-bind:is="activeNavigatorWindow.content"></component>
      </window>
    </div>


    <!-- desktop icon grid -->
    <div class="icon-grid">
      <div @click="openPortfolio" class="icon folder">
        <div class="rotation-container" v-bind:style="{ transform: 'rotationX(' + rotationX + 'deg)' }">
          <img src="../assets/folder-icon.svg">
        </div>
        <div class="caption">Hotmax Portfolio</div>
      </div>
      <div @click="openNavigatorWindow(navigatorWindows.rubbish)" class="icon rubbish">
        <img src="../assets/rubbish-icon.svg">
        <div class="caption">Rubbish Bin</div>
      </div>
      <div @click="openOverflowConsole(consoleTexts.aboutUs)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">About Us</div>
      </div>
      <div @click="openOverflowConsole(consoleTexts.ourServices)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">Our Services</div>
      </div>
      <div @click="openOverflowConsole(consoleTexts.contactUs)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">Contact Us</div>
      </div>
    </div>


  </div>
  </transition>
</template>

<script lang="coffee">
interact = require('interact.js')

module.exports =
  name: 'projectsPanel'
  components:
    Window:       require './Window'
    RubbishBin:   require './RubbishBin'
    Portfolio:    require './Portfolio'
    #content components
    DigitalTextbook:  require '../projects/DigitalTextbook/DigitalTextbook'
    VideoPortal:      require '../projects/VideoPortal/VideoPortal'
    Whereyaat:        require '../projects/Whereyaat/Whereyaat'
    Ibes:             require '../projects/Ibes/Ibes'
    ArSynth:          require '../projects/ArSynth/ArSynth'
    Translation:      require '../projects/Translation/Translation'
    Walkthrough:      require '../projects/Walkthrough/Walkthrough'


  data: ->
    rotationX: 10
    rotationY: 10


  methods:
    openPortfolio: ()->
      @$store.dispatch 'openPortfolio'
    openOverflowConsole: (view)->
      @$store.dispatch 'openOverflowConsole', view

    openOverlay: (view)->
      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', view
    openNavigatorWindow: (view)->
      @$store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_NAVIGATOR_WINDOW', view

  computed:
    additionalTitle: ->
      if @projectWindowIsOpen
        return " >> #{@activeProjectWindow.meta.shortTitle}"
      else
        return ''

    #vuex state
    projectWindowIsOpen: ->   return @$store.state.projectWindowIsOpen
    activeProjectWindow: ->   return @$store.state.activeProjectWindow
    navigatorWindowIsOpen: -> return @$store.state.navigatorWindowIsOpen
    activeNavigatorWindow: -> return @$store.state.activeNavigatorWindow
    portfolioWindowIsOpen: -> return @$store.state.portfolioWindowIsOpen

    overlays: ->              return @$store.state.overlays
    projectWindows: ->        return @$store.state.projectWindows
    navigatorWindows: ->      return @$store.state.navigatorWindows
    consoleTexts: ->          return @$store.state.consoleTexts



</script>

<style lang="sass">
@import src/styles/main

#projects-panel
  position: relative
  +flex(1 1 50%)
  +flexbox
  height: 100%
  +align-items(center)
  +flex-direction(column)
  +justify-content(center)
  z-index: 999

  .window-container
    width: 110%
    height: 80%
    z-index: 999
    background-color: white
    position: relative
    &.projectWindow
      +translate3d(70px,0,0)
      z-index: 9999
    &.navigator
      position: absolute
      top: 50%
      left: 50%
      +translateXY(-50%, -50%)
    &.RubbishBin
      width: 59%
      height: 50%
    &.Portfolio
      position: absolute
      +translate3d(70px,0,0)



  .icon-grid
    z-index: 9
    position: absolute
    width: 99%
    height: 100%
    top: 50%
    left: 50%
    +translateXY(-50%, -50%)
    +flexbox
    +align-items(center)
    +justify-content(center)

    // testing matrix transform
    -moz-transform-style: preserve-3d
    -webkit-transform-style: preserve-3d
    transform-style: preserve-3d
    -moz-backface-visibility: hidden
    -webkit-backface-visibility: hidden
    backface-visibility: hidden
    -moz-perspective: 800px
    -webkit-perspective: 800px
    perspective: 800px
    -moz-transform-origin: 50% 50% 0
    -webkit-transform-origin: 50% 50% 0
    transform-origin: 50% 50% 0


    .icon
      position: absolute
      top: 50%
      left: 50%
      +clickable

      &:nth-child(3)
        +translate3d(-60px, -20px, 0px)
      &:nth-child(4)
        +translate3d(40px, 0px, 0)
      &:nth-child(5)
        +translate3d(-160px, 10px, 0)
      .caption
        padding: 5px 0 0 10px
        font-size: 15px
        line-height: 17px
      &.rubbish
        width: 77px
        left: 60px
        +translate3d(50px, 150px, 0)
      &.folder
        width: 85px
        left: 60px
        +translate3d(50px, -150px, 0)
      &.file
        width: 60px


</style>
