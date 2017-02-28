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

      <div class="icon-group">
        <div @click="openPortfolio" class="icon folder">
          <img src="../assets/folder-icon.svg">
          <div class="caption">Collected Work</div>
        </div>
        <div @click="openOverlay(consoleTexts.contactUs)" class="icon file" :class="{ active: checkActive(consoleTexts.contactUs)  }">
          <img src="../assets/file-icon.svg">
          <div class="caption">Contact Us</div>
        </div>
      </div>

      <div class="icon-group">
        <div @click="openOverlay(consoleTexts.aboutUs)" class="icon file" :class="{ active: checkActive(consoleTexts.aboutUs)  }">
          <img src="../assets/file-icon.svg">
          <div class="caption">About Us</div>
        </div>
        <div @click="openOverlay(consoleTexts.ourServices)" class="icon file" :class="{ active: checkActive(consoleTexts.ourServices)  }">
          <img src="../assets/file-icon.svg">
          <div class="caption">Our Services</div>
        </div>
      </div>

      <div class="icon-group">
        <div @click="openNavigatorWindow(navigatorWindows.rubbish)" class="icon rubbish">
          <img src="../assets/rubbish-icon.svg">
          <div class="caption">Rubbish Bin</div>
        </div>
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
    ArSynth:          require '../projects/ArSynth/ArSynth'
    Translation:      require '../projects/Translation/Translation'
    Walkthrough:      require '../projects/Walkthrough/Walkthrough'


  data: ->
    rotationX: 10
    rotationY: 10


  methods:
    checkActive: (icon)->
      if @overflowConsoleIsOpen and @overflowConsoleText is icon
        return true
      else return false
    openPortfolio: ()->
      @$store.dispatch 'openPortfolio'
    openOverflowConsole: (view)->
      @$store.dispatch 'openOverflowConsole', view
    openOverlay: (view)->
      overlay = view
      overlay.orientation = 'portrait'
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

    overflowConsoleText: ->   return @$store.state.overflowConsoleText
    overflowConsoleIsOpen: -> return @$store.state.overflowConsoleIsOpen

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
  +screen(mobile)
    +flex(1 1 1)

  .window-container
    width: 110%
    height: 90%
    z-index: 999
    background-color: white
    position: relative
    &.projectWindow
      +translateXY(70px,0)
      z-index: 9999
      +screen(mobile)
        +translateXY(0,0)
        width: 100%
      +screen(tablet)
        +translateXY(0,0)
        width: 100%
    &.navigator
      position: absolute
      top: 50%
      left: 50%
      +translateXY(-50%, -50%)
    &.RubbishBin
      width: 59%
      height: 50%
      z-index: 999
    &.Portfolio
      position: absolute
      +translateXY(70px,0)
      +screen(mobile)
        +translateXY(0,0)
        width: 100%
      +screen(tablet)
        +translateXY(0,0)
        width: 100%



  .icon-grid
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
      &:nth-last-child(1)
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


</style>
