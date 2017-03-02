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
    <icon-grid></icon-grid>

    <!-- helper popups -->
    <!-- <popup-panel></popup-panel> -->


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
    IconGrid:     require './IconGrid'
    PopupPanel:   require './PopupPanel'


    #content components
    DigitalTextbook:  require '../projects/DigitalTextbook/DigitalTextbook'
    VideoPortal:      require '../projects/VideoPortal/VideoPortal'
    Whereyaat:        require '../projects/Whereyaat/Whereyaat'
    ArSynth:          require '../projects/ArSynth/ArSynth'
    Translation:      require '../projects/Translation/Translation'
    Walkthrough:      require '../projects/Walkthrough/Walkthrough'

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
    +screen(mobile)
      height: 100%
    &.projectWindow
      +translateXY(70px,0)
      z-index: 9999
      +screen(mobile)
        +translateXY(0,0)
        width: 100%
      +screen(tablet)
        +translateXY(0,0)
        width: 90%
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


</style>
