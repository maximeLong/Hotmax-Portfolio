<template>
  <div id="app" :class="{ entryMode: entryIndex < 2 }">

    <!-- entry logo and text that appears above planets -->
    <logo-entry
      v-if="entryIndex == 1"
    ></logo-entry>

    <!-- main desktop container, enters on entryIndex == 2 -->
    <transition appear name="slowfade">
      <div id="desktop-experience" v-if="entryIndex > 1">

        <div id="body-container">
          <projects-panel v-if="projectPanelVisibility"></projects-panel>
          <console-panel v-if="handleConsoleVisibility"></console-panel>
          <div id="overlay-container" v-if="overlayIsOpen">
            <overlay-panel></overlay-panel>
          </div>
        </div>

        <div id="footer-container">
          <transition appear v-on:enter="beginShowingDesktop()" name="fadeup">
            <footer-panel></footer-panel>
          </transition>
        </div>

      </div>
    </transition>

    <!-- persistent three container, dont show on mobile -->
    <div class="three-container" v-if="port != 'mobile'">
      <transition name="glitch">
        <div class="growth-container" ref="three"
             v-if="entryIndex > 0"
             :class="{ entry: entryIndex == 1, desktop: entryIndex > 1 }"
             :style="{ width: threeWidth + 'px' }">
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
    LogoEntry:      require './components/LogoEntry'
    ProjectsPanel:  require './components/ProjectsPanel'
    ConsolePanel:   require './components/ConsolePanel'
    FooterPanel:    require './components/FooterPanel'
    OverlayPanel:   require './components/OverlayPanel'
    Three:          require './components/Three'

  data: ->
    threeMode:    'entry'
    overlayHeight: 90
    overlayWidth:  70
    threeWidth:    ''

  mounted: ->
    
    #TODO: this should really be in init plugin but router has a race condition
    if @$store.state.route.path is '/'
      @$store.commit 'SET_ENTRY_INDEX', 1
    else
      @$store.commit 'SET_ENTRY_INDEX', 2

    # pass entryIndex info down into three.js component
    @$watch 'entryIndex', (index)=>
      if index is 2
        @changeSunPosition()

    # reset the three circle width on a resize TODO: also do the vertical width
    window.addEventListener 'resize', ()=>
      if @threeMode is 'desktop'
        @threeWidth = @$refs.three?.clientHeight


  computed:
    # show console fully on desktop, on tablet only show on landing
    handleConsoleVisibility: ->
      if @consolePanelVisibility
        if @port is 'tablet'
          return false if @portfolioWindowIsOpen or @projectWindowIsOpen
        if @port is 'mobile' then return false
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
    # vuex mutators
    beginShowingDesktop: ->
      setTimeout =>
        @$store.commit 'SET_PROJECT_PANEL_VISIBILITY', true
      , 2500
      setTimeout =>
        @$store.commit 'SET_CONSOLE_PANEL_VISIBILITY', true
      , 2500

    changeSunPosition: ->
      @threeMode = 'desktop' #set desktop mode to show everything
      @threeWidth = @$refs.three?.clientHeight #set width of new three container
      if @soundIsOn
        audio = new Audio("/static/wavs/opening/start.wav");
        audio.play()
      setTimeout =>
        @$store.commit 'SET_THREE_GLITCH', false
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
