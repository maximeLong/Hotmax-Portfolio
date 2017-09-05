<template>
  <div id="app" :class="{ entryMode: entryIndex == 1 }">

    <!-- entry logo and text that appears above initial planets -->
    <logo-entry
      v-if="entryIndex == 1"
      v-on:done="runNarrativeEntry">
    </logo-entry>


    <!-- main desktop container, enters on hub mode -->
      <transition name="slowfade">
    <div id="desktop-experience" v-if="entryIndex > 1">

      <div id="body-container">
        <projects-panel v-if="projectPanelVisibility"></projects-panel>
        <console-panel v-if="handleConsoleVisibility"></console-panel>
        <div id="overlay-container" v-if="overlayIsOpen">
          <overlay-panel></overlay-panel>
        </div>
      </div>

      <div id="footer-container">
        <transition appear v-on:enter="beginShowingHub()" name="fadeup">
          <footer-panel></footer-panel>
        </transition>
      </div>

    </div>
      </transition>


    <!-- persistent three container, dont show on mobile -->
    <div class="three-container" v-if="showThreeJS">

      <div class="planet-container" ref="three"
        :class="planetContainer.type"
        :style="{width: planetContainer.width}">

        <three
          :cameraPosition="cameraPosition"
          :animateCameraChange="animateCameraChange"
          :glitch="showThreeGlitch"
          :sound="soundIsOn"
          v-if="webGlIsWorking">
        </three>

      </div>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =

  name: 'app'
  components:
    LogoEntry:      require './components/LogoEntry'
    ProjectsPanel:  require './components/ProjectsPanel'
    ConsolePanel:   require './components/ConsolePanel'
    FooterPanel:    require './components/FooterPanel'
    OverlayPanel:   require './components/OverlayPanel'
    Three:          require './components/Three'

  data: ->
    cameraPosition:      'entry'
    animateCameraChange: false
    hideThreeJS: true
    planetContainer:
      type: 'entry'
      width: '100%'

  mounted: ->

    #TODO: move to some other init place -- checks if entry experience is needed or can be skipped
    if @$store.state.route.path is '/'
      @$store.commit 'SET_ENTRY_ROUTE', '/'
      @$store.commit 'SET_ENTRY_INDEX', 1
      @hideThreeJS = false
    else
      @$store.commit 'SET_ENTRY_ROUTE', @$store.state.route.path
      @$store.commit 'SET_ENTRY_INDEX', 2
      @hideThreeJS = true
      #@setPlanetsToHubMode()


    # reset the three circle width on a resize TODO: also do the vertical width
    window.addEventListener 'resize', ()=>
      if @cameraPosition is 'hub'
        @threeWidth = @$refs.three?.clientHeight


  computed:
    # show console fully on desktop, on tablet only show on landing
    handleConsoleVisibility: ->
      if @consolePanelVisibility
        if @port is 'tablet'
          return false if @portfolioWindowIsOpen or @projectWindowIsOpen
        if @port is 'mobile' then return false
        else return true

    showThreeJS: ->
      if @port is 'mobile' or @hideThreeJS
        return false
      else return true


    # vuex store
    port: -> return @$store.state.port
    portfolioWindowIsOpen: -> return @$store.state.portfolioWindowIsOpen
    projectWindowIsOpen:   -> return @$store.state.projectWindowIsOpen

    entryIndex: ->  return @$store.state.entryIndex
    projectPanelVisibility: -> return @$store.state.projectPanelVisibility
    consolePanelVisibility: -> return @$store.state.consolePanelVisibility
    overlayIsOpen: -> return @$store.state.overlayIsOpen
    activeOverlay: -> return @$store.state.activeOverlay
    showThreeGlitch: -> return @$store.state.showThreeGlitch
    webGlIsWorking:  -> return @$store.state.webGlIsWorking
    soundIsOn:       -> return @$store.state.soundIsOn

  methods:
    beginShowingHub: ->
      duration = 2500
      if @$store.state.route.path is '/' then duration = 2500 else duration = 500
      setTimeout =>
        @$store.commit 'SET_PROJECT_PANEL_VISIBILITY', true
      , duration
      setTimeout =>
        @$store.commit 'SET_CONSOLE_PANEL_VISIBILITY', true
      , duration

    setPlanetsToHubMode: ->
      @cameraPosition = 'hub'                     # move camera to hub position
      @animateCameraChange = true                # animate change
      @planetContainer.type = 'hubIsActive'
      #TODO: this is completely stupid
      setTimeout =>
        @planetContainer.width = @$refs.three.clientHeight + 'px'
      , 50

    runNarrativeEntry: ->
      @$store.commit 'SET_ENTRY_INDEX', 2         # move entry index forward
      @setPlanetsToHubMode()                      # set planets
      if @soundIsOn
        audio = new Audio("/static/wavs/opening/start.wav");
        audio.play()
      setTimeout =>
        @$store.commit 'SET_THREE_GLITCH', false  # set glitch to false
        @animateCameraChange = false              # have animation go back to being false
        @planetContainer.width = @$refs.three.clientHeight + 'px' # just to be safe
      , 3500

    toggleSound: -> @$store.commit 'TOGGLE_SOUND', !@soundIsOn


</script>

<style lang="sass">
@import src/styles/main

#app
  position: relative
  width: 100vw
  height: 100vh
  overflow: hidden
  background-color: #0b3039
  transition: 0.15s ease all
  +transition(.15s ease all)
  &.entryMode
    background-color: black
    +transition(.15s ease all)


  .three-container
    width: 100%
    height: 100%
    z-index: 9
    +flexbox
    +align-items(center)
    +justify-content(center)
    .planet-container
      position: relative
      +flexbox
      +align-items(center)
      +justify-content(center)
      &.hubIsActive
        // width is overriden by vue
        width: 50%
        height: 50%
        border-radius: 100%
        background-color: $ink_black
        +scale(1)
        &::after
          content: ''
          position: absolute
          width: 108%
          height: 108%
          border-radius: 100%
          border: 2px solid $ink_black
          top: 50%
          left: 50%
          +translateXY(-50%, -50%)


  #entry-experience
    height: 100%
    width: 100%
    overflow-x: hidden
    overflow-y: hidden
    +flexbox
    +align-items(center)
    +justify-content(center)
  #desktop-experience
    +defaultType(normal)
    position: absolute
    top: 0
    left: 0
    height: 100%
    width: 100%
    overflow-x: hidden
    overflow-y: hidden
    background-color: #f5e6e3

    #footer-container
      height: 60px
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
      height: calc(100% - 60px)
      margin: 0 auto
      z-index: 9999
      +flexbox
      +align-items(center)
      +justify-content(center)
      +screen(mobile)
        width: 100%
        max-width: 100%
        min-width: 0
      +screen(tablet)
        width: 80%
        max-width: 100%



</style>
