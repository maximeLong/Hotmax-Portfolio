<template>
  <div id="app">

    <div id="entry-experience" v-if="entryIndex == 0">
      <entry></entry>
    </div>

    <transition appear name="fadedown">
      <div id="desktop-experience" v-if="entryIndex > 1">

        <div id="header-container">
          <transition appear v-on:enter="beginShowingDesktop()" name="fadedown">
            <header-panel></header-panel>
          </transition>
        </div>

        <div id="body-container">
          <projects-panel v-if="projectPanelVisibility"></projects-panel>
          <console-panel v-if="consolePanelVisibility"></console-panel>
          <div id="overlay-container" v-if="overlayIsOpen" v-bind:style="{ height: 'calc(' + overlayHeight + '% - 60px)', width: overlayWidth + '%' }">
            <overlay-panel></overlay-panel>
          </div>
        </div>
      </div>
    </transition>

    <button v-on:click="setEntryIndex(2)" v-if="entryIndex < 2" class="entry-btn">close entry</button>

    <div class="three-container">

      <transition name="glitch">
        <div class="growth-container" v-if="entryIndex > 0" :class="{ entry: entryIndex == 1, desktop: entryIndex > 1 }">
            <three :mode="threeMode" :glitch="showThreeGlitch" v-if="webGlIsWorking"></three>
        </div>
      </transition>

    </div>

  </div>
</template>

<script lang="coffee">
module.exports =

  name: 'app'
  components:
    Entry: require './components/Entry'
    ProjectsPanel: require './components/ProjectsPanel'
    ConsolePanel: require './components/ConsolePanel'
    HeaderPanel: require './components/HeaderPanel'
    OverlayPanel: require './components/OverlayPanel'
    Three: require './components/Three'

  data: ->
    threeMode: 'entry'
    overlayHeight: 90
    overlayWidth: 70


  mounted: ->
    # have to set overlay height and width outside of component
    @$watch 'activeOverlay', (overlay)->
      if overlay.title is 'asteroids.exe'
        @overlayHeight = 90
        @overlayWidth = 70
      else
        @overlayHeight = 100
        @overlayWidth = 50

    # pass entryIndex info down into three.js component
    @$watch 'entryIndex', (index)->
      if index is 2
        @threeMode = 'desktop'
        @$store.commit 'SET_THREE_GLITCH', true
        setTimeout =>
          @$store.commit 'SET_THREE_GLITCH', false
        , 3500



  computed:
    # vuex store
    entryIndex: -> return @$store.state.entryIndex
    projectPanelVisibility: -> return @$store.state.projectPanelVisibility
    consolePanelVisibility: -> return @$store.state.consolePanelVisibility

    overlayIsOpen: -> return @$store.state.overlayIsOpen
    activeOverlay: -> return @$store.state.activeOverlay

    showThreeGlitch: -> return @$store.state.showThreeGlitch
    webGlIsWorking:  -> return @$store.state.webGlIsWorking

  methods:
    # vuex mutators
    beginShowingDesktop: ->
      setTimeout =>
        @$store.commit 'SET_PROJECT_PANEL_VISIBILITY', true
      , 1000
      setTimeout =>
        @$store.commit 'SET_CONSOLE_PANEL_VISIBILITY', true
      , 2500

    setEntryIndex: (index)-> @$store.commit 'SET_ENTRY_INDEX', index


</script>

<style lang="sass">
@import src/styles/main

#app
  position: relative
  width: 100vw
  height: 100vh
  overflow: hidden
  background-color: $ink_black


  .entry-btn
    position: absolute
    top: 200px
    left: 300px
    z-index: 99999

  .three-container
    width: 100%
    height: 100%
    z-index: 9
    +flexbox
    +align-items(center)
    +justify-content(center)
    .growth-container
      position: relative
      +flexbox
      +align-items(center)
      +justify-content(center)
      &.desktop
        width: 500px
        height: 500px
        border-radius: 100%
        background-color: $ink_black
        &::after
          content: ''
          position: absolute
          width: 108%
          height: 108%
          border-radius: 100%
          border: 2px solid $ink_black
        &::before
          +defaultType
          content: 'Afternoon Indians Logo'
          text-align: center
          position: absolute
          width: 100%
          height: 125px
          bottom: -200px
          // background-image: url('assets/sisyphus-logo-small.svg')
          // background-position: 50% 100%
          // background-size: 100%
          // background-repeat: no-repeat


  #entry-experience
    +defaultType
    color: white
    height: 100vh
    width: 100vw
    overflow-x: hidden
    overflow-y: hidden
    +flexbox
    +flex-direction(column)
    +align-items(center)
    +justify-content(center)
    background-color: $ink_black
  #desktop-experience
    +defaultType
    position: absolute
    top: 0
    left: 0
    height: 100vh
    width: 100vw
    overflow-x: hidden
    overflow-y: hidden
    background-color: white
    #header-container
      height: 60px
    #body-container
      height: calc(100% - 60px)
      +flexbox
      +flex-direction(row)
      +align-content(center)
    #overlay-container
      position: absolute
      right: 0
      left: 0
      top: 0
      bottom: 0
      width: 60%
      min-width: 500px
      height: calc(100% - 60px)
      margin: 0 auto
      margin-top: 60px
      z-index: 999
      +flexbox
      +align-items(center)
      +justify-content(center)



</style>
