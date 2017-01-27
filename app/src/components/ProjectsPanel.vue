<template>
  <transition appear name="fade">
  <div id="projects-panel">
    <div class="icon-grid">
      <div @click="openNavigatorWindow(navigatorWindows.rubbish)" class="icon rubbish">
        <img src="../assets/rubbish-icon.svg">
        <div class="caption">Rubbish Bin</div>
      </div>
      <div @click="openNavigatorWindow(navigatorWindows.portfolio)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Our Work</div>
      </div>
      <div @click="openProjectWindow(projectWindows.curriculum)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Choices Curriculum</div>
      </div>
      <div @click="openProjectWindow(projectWindows.video)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Video Portal</div>
      </div>
      <div @click="openProjectWindow(projectWindows.curriculum)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Whereyaat Social</div>
      </div>
    </div>

    <!-- project window -->
    <div class="window-container" v-if="projectWindowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::Portfolio >> ' + activeProjectWindow.meta.shortTitle"
        :type="'portfolio'">

        <component v-bind:is="activeProjectWindow.content"></component>

      </window>
    </div>

    <!-- navigator window -->
    <div class="window-container navigator" :class="activeNavigatorWindow.content" v-if="navigatorWindowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::' + activeNavigatorWindow.shortTitle"
        :type="'navigator'"
        :toggleContainer="activeNavigatorWindow.content == 'Portfolio' ? true : false">

        <component v-bind:is="activeNavigatorWindow.content"></component>

      </window>
    </div>

  </div>
  </transition>
</template>

<script lang="coffee">
interact = require('interact.js')

module.exports =
  name: 'projectsPanel'
  components:
    Window: require './Window'

    #content components
    DigitalTextbook:  require '../projects/DigitalTextbook/DigitalTextbook'
    VideoPortal:      require '../projects/VideoPortal/VideoPortal'
    RubbishBin:       require './RubbishBin'
    Portfolio:        require './Portfolio'


  data: ->
    navigatorWindows:
      rubbish:
        content:    'RubbishBin'
        shortTitle: 'Rubbish Bin'
        readMe: ''
      portfolio:
        content:    'Portfolio'
        shortTitle: 'Afternoon Indians >> Portfolio'
        readMe: ''


  methods:
    openProjectWindow: (view)->
      @$store.commit 'SET_PROJECT_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_PROJECT_WINDOW', view
    openOverlay: (view)->
      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', view
    openNavigatorWindow: (view)->
      @$store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_NAVIGATOR_WINDOW', view

  computed:
    #vuex
    projectWindowIsOpen: ->   return @$store.state.projectWindowIsOpen
    activeProjectWindow: ->   return @$store.state.activeProjectWindow
    navigatorWindowIsOpen: -> return @$store.state.navigatorWindowIsOpen
    activeNavigatorWindow: -> return @$store.state.activeNavigatorWindow
    overlays: ->              return @$store.state.overlays
    projectWindows: ->        return @$store.state.projectWindows



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

  .window-container
    width: 88%
    height: 90%
    z-index: 999
    background-color: white
    position: relative
    &.navigator
      position: absolute
      z-index: 99
    &.RubbishBin
      width: 60%
      height: 50%
      +translate3d(-30px, -60px, 0)
    &.Portfolio
      width: 85%
      height: 70%


  .icon-grid
    position: absolute
    top: 50px
    left: 50px
    width: 50%
    .icon
      position: absolute
      +clickable
      &:nth-child(2)
        +translate3d(110px, 40px, 0)
      &:nth-child(3)
        +translate3d(0, 220px, 0)
      &:nth-child(4)
        +translate3d(130px, 250px, 0)
      &:nth-child(5)
        +translate3d(260px, 220px, 0)

      .caption
        padding: 5px 0 0 10px
        line-height: 16px
      &.rubbish
        width: 65px
      &.folder
        width: 75px
      &.file
        width: 57px


</style>
