<template>
  <div id="app" :class="{ entryMode: entryIndex < 2 }">

    <logo-entry
      v-if="entryIndex == 1"
      :entryTimer="entryTimer"
      v-on:logoDone="logoDone = true"
    ></logo-entry>

    <!-- main desktop container -->
    <transition appear name="slowfade">
      <div id="desktop-experience" v-if="entryIndex > 1">

        <div id="body-container">
          <projects-panel v-if="projectPanelVisibility"></projects-panel>
          <console-panel v-if="handleConsoleVisibility"></console-panel>
          <div id="overlay-container" v-if="overlayIsOpen">
            <overlay-panel></overlay-panel>
          </div>
        </div>

        <div id="header-container">
          <transition appear v-on:enter="beginShowingDesktop()" name="fadeup">
            <header-panel></header-panel>
          </transition>
        </div>

      </div>
    </transition>

    <!-- persistent three container, only show on desktop -->
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

    <!-- handles click sounds and shit -->
    <click-handler></click-handler>

  </div>
</template>

<script lang="coffee">
module.exports =

  name: 'app'
  components:
    Entry:          require './components/Entry'
    LogoEntry:      require './components/LogoEntry'
    ProjectsPanel:  require './components/ProjectsPanel'
    ConsolePanel:   require './components/ConsolePanel'
    HeaderPanel:    require './components/HeaderPanel'
    OverlayPanel:   require './components/OverlayPanel'
    Three:          require './components/Three'
    ClickHandler:   require './components/ClickHandler'

  data: ->
    threeMode:    'entry'
    overlayHeight: 90
    overlayWidth:  70
    threeWidth:    ''
    entryTimer:    null
    logoDone:      false


  mounted: ->

    #intro listeners
    @$watch 'logoDone', (val)->
      if val is true
        if @port is 'desktop'
          window.addEventListener 'keydown', (e)=>
            @introDownEvent(e, 'key')
          window.addEventListener 'keyup', (e)=>
            @introUpEvent(e, 'key')
        if @port != 'desktop'
          document.getElementById('thumbprint').addEventListener 'touchstart', (e)=>
            @introDownEvent(e, 'touch')
          document.getElementById('thumbprint').addEventListener 'touchend', (e)=>
            @introUpEvent(e, 'touch')
          document.getElementById('thumbprint').addEventListener 'mousedown', (e)=>
            @introDownEvent(e, 'touch')
          document.getElementById('thumbprint').addEventListener 'mouseup', (e)=>
            @introUpEvent(e, 'touch')



    # pass entryIndex info down into three.js component
    @$watch 'entryIndex', (index)->
      if index is 2
        @threeMode = 'desktop' #set desktop mode to show everything
        @threeWidth = @$refs.three?.clientHeight #set width of new three container
        if @soundIsOn
          audio = new Audio("/static/wavs/opening/start.wav");
          audio.play()
        setTimeout =>
          @$store.commit 'SET_THREE_GLITCH', false
        , 3500

    window.addEventListener 'resize', ()=>
      if @threeMode is 'desktop'
        @threeWidth = @$refs.three?.clientHeight



  computed:
    # show on desktop, not on mobile, on tablet only show on landing
    handleConsoleVisibility: ->
      if @consolePanelVisibility
        if @port is 'tablet'
          return false if @portfolioWindowIsOpen or @projectWindowIsOpen
        if @port is 'mobile' then return false
        else return true

    # vuex store
    port: ->        return @$store.state.port
    portfolioWindowIsOpen: -> return @$store.state.portfolioWindowIsOpen
    projectWindowIsOpen:   -> return @$store.state.projectWindowIsOpen

    entryIndex: ->  return @$store.state.entryIndex
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
      , 2500

    introDownEvent: (e, type)->
      if @entryIndex is 1
        if (type is 'key' and e.code is 'Space') or type is 'touch'
          @$store.commit 'SET_THREE_GLITCH', true
          if @entryTimer is null
            @entryTimer =
              setTimeout =>
                @setEntryIndex(2)
              , 3000
    introUpEvent: (e, type)->
      if @entryIndex is 1
        if (type is 'key' and e.code is 'Space') or type is 'touch'
          @$store.commit 'SET_THREE_GLITCH', false
          clearTimeout(@entryTimer)
          @entryTimer = null

    setEntryIndex: (index)-> @$store.commit 'SET_ENTRY_INDEX', index
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
        // +screen(desktop)
        //   &::before
        //     +transition(.15s ease all)
        //     opacity: .8
        //     +defaultType(normal)
        //     content: 'ホットマックス'
        //     font-size: 60px
        //     line-height: 44px
        //     color: inherit
        //     text-align: center
        //     position: absolute
        //     width: 150%
        //     height: 125px
        //     bottom: -200px
        //     right: 50%
        //     +translateX(50%)


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

    #header-container
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
        // padding: 0 30px
        width: 80%
        max-width: 100%



</style>
