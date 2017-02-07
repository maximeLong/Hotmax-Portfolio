<template>
  <div id="header-panel">
    <div class="logo">
      <img src="../assets/logo2.png">
      <!-- <span>Interactive Design Agency</span> -->
    </div>
    <div class="other-stuff">
      <div class="about"@click="openConsoleText(consoleTexts.ourServices)">:about</div>
      <div class="work" @click="openNavigatorWindow(navigatorWindows.portfolio)">:our work</div>
      <div class="sound" @click="toggleSound">
        <span v-for="i in 5" :class="{soundOn: soundIsOn, soundOff: !soundIsOn}"></span>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'headerPanel'

  computed:
    soundIsOn: ->             return @$store.state.soundIsOn
    navigatorWindowIsOpen: -> return @$store.state.navigatorWindowIsOpen
    activeNavigatorWindow: -> return @$store.state.activeNavigatorWindow
    navigatorWindows: ->      return @$store.state.navigatorWindows
    consoleTexts:     ->      return @$store.state.consoleTexts

  methods:
    toggleSound: -> @$store.commit 'TOGGLE_SOUND', !@soundIsOn
    openNavigatorWindow: (view)->
      @$store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_NAVIGATOR_WINDOW', view
    openConsoleText: (view)->
      @$store.commit 'SET_CONSOLE_TEXT_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_CONSOLE_TEXT', view

</script>

<style lang="sass">
@import src/styles/main

#header-panel
  position: relative
  width: 100%
  height: 100%
  z-index: 9999
  +flexbox
  +align-items(center)
  +justify-content(space-between)
  +flex-direction(row)
  padding: 0 30px
  border: 3px solid white

  .logo
    +flexbox
    +align-items(row)
    +align-items(center)
    // width: 200px
    height: 40px
    span
      margin-left: 20px
      +showyType
      font-size: 14px
      letter-spacing: 1px
    img
      width: auto
      height: 100%

  .other-stuff
    +flexbox
    +align-items(row)
    +align-items(center)
    +justify-content(space-between)
    width: 300px
    font-size: 16px
    font-weight: bold
    color: $ink_black
    .about
      cursor: pointer
    .work
      cursor: pointer
    .sound
      cursor: pointer
      width: 40px
      height: 20px
      +flexbox
      +flex-direction(row)
      +align-items(flex-end)
      +justify-content(space-between)
      span
        opacity: .9
        height: 100%
        width: 3px
        background-color: $ink_black
        display: block
        +transition(.15s ease all)
        &.soundOn
          animation: sound-on 1s infinite
          +transition(.15s ease all)
          &:nth-last-of-type(1)
            animation: sound-on 2s infinite
          &:nth-last-of-type(2)
            animation: sound-on 1.5s infinite
          &:nth-last-of-type(3)
            animation: sound-on 1s infinite
          &:nth-last-of-type(5)
            animation: sound-on 1.2s infinite
        &.soundOff
          height: 30%
          opacity: .5
          +transition(.15s ease all)





</style>
