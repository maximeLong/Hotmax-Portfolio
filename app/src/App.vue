<template>
  <div id="app" :class="{ entryMode: entryIndex < 2 }">

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
          <div id="overlay-container" v-if="overlayIsOpen" v-bind:style="{ height: overlayHeight + '%', width: overlayWidth + '%' }">
            <overlay-panel></overlay-panel>
          </div>

        </div>
      </div>
    </transition>

    <button class="entry-btn"
      v-if="entryIndex == 1"
      @click="setEntryIndex(2)">open to desktop</button>


    <div class="three-container">

      <transition name="glitch">
        <div class="growth-container" ref="three"
             v-if="entryIndex > 0"
             :class="{ entry: entryIndex == 1, desktop: entryIndex > 1 }"
             :style="{ width: threeWidth + 'px' }"
        >
            <three :mode="threeMode" :glitch="showThreeGlitch" :sound="soundIsOn" v-if="webGlIsWorking"></three>
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
    threeWidth: ''


  mounted: ->
    # have to set overlay height and width outside of component
    @$watch 'activeOverlay', (overlay)->
      if overlay.title is 'asteroids.exe'
        @overlayHeight = 90
        @overlayWidth = 70
      else
        @overlayHeight = 100
        @overlayWidth = 70

    # pass entryIndex info down into three.js component
    @$watch 'entryIndex', (index)->
      if index is 2
        @threeMode = 'desktop' #set desktop mode to show everything
        @threeWidth = @$refs.three?.clientHeight #set width of new three container
        @$store.commit 'SET_THREE_GLITCH', true
        if @soundIsOn
          audio = new Audio("/static/wavs/opening/tuning.wav");
          audio.play()
        setTimeout =>
          @$store.commit 'SET_THREE_GLITCH', false
        , 3500

    window.addEventListener 'resize', ()=>
      if @threeMode is 'desktop'
        @threeWidth = @$refs.three?.clientHeight



  computed:

    # vuex store
    entryIndex: -> return @$store.state.entryIndex
    projectPanelVisibility: -> return @$store.state.projectPanelVisibility
    consolePanelVisibility: -> return @$store.state.consolePanelVisibility
    systemColor: ->            return @$store.state.systemColor
    overlayIsOpen: -> return @$store.state.overlayIsOpen
    activeOverlay: -> return @$store.state.activeOverlay
    showThreeGlitch: -> return @$store.state.showThreeGlitch
    webGlIsWorking:  -> return @$store.state.webGlIsWorking
    soundIsOn:       -> return @$store.state.soundIsOn

  methods:
    # vuex mutators
    beginShowingDesktop: ->
      setTimeout =>
        @$store.commit 'SET_PROJECT_PANEL_VISIBILITY', true
      , 2500
      setTimeout =>
        @$store.commit 'SET_CONSOLE_PANEL_VISIBILITY', true
        if @soundIsOn
          audio = new Audio("/static/wavs/opening/consoleOpen.wav");
          audio.play()
      , 2500

    setEntryIndex: (index)-> @$store.commit 'SET_ENTRY_INDEX', index


</script>

<style lang="sass">
@import src/styles/main

#app
  position: relative
  width: calc(100vw - 40px)
  height: calc(100vh - 40px)
  overflow: hidden
  background-color: #0b3039
  transition: 0.15s ease all
  margin: 20px
  box-shadow: 0 0 30px 9px rgb(245, 230, 227)
  +transition(.15s ease all)
  &.entryMode
    background-color: black
    +transition(.15s ease all)

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
        // width is overriden by vue
        width: 50%
        height: 50%
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
          +transition(.15s ease all)
          opacity: .8
          +defaultType
          content: 'ホットマックス'
          font-size: 60px
          line-height: 44px
          color: inherit
          text-align: center
          position: absolute
          width: 150%
          height: 125px
          bottom: -200px


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
  #desktop-experience
    +defaultType
    position: absolute
    top: 0
    left: 0
    height: 100%
    width: 100%
    overflow-x: hidden
    overflow-y: hidden
    background-color: #f5e6e3
    // &::after
    //   opacity: .5
    //   position: absolute
    //   left: 0
    //   top: 0
    //   content: ''
    //   display: block
    //   height: 100%
    //   width: 100%
    //   background-image: url('assets/left-grad.png')
    //   background-position: 0% 0%
    //   background-size: contain
    //   background-repeat: no-repeat
    #header-container
      height: 60px
      padding: 0 30px
      width: 100%
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
      width: 70%
      min-width: 500px
      max-width: 1200px
      height: 100%
      +translate3d(0,-50px,0)
      margin: 0 auto
      margin-top: 60px
      z-index: 9999
      +flexbox
      +align-items(center)
      +justify-content(center)



</style>
