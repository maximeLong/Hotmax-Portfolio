<template>
  <div id="header-panel">
    <div class="logo">
      <img src="../assets/logo2.png">
    </div>
    <div class="other-stuff">
      <div class="about"@click="openOverflowConsole(consoleTexts.ourServices)">:about</div>
      <div class="work" @click="openPortfolioWindow()">:our work</div>
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
    toggleSound: ->
      @$store.commit 'TOGGLE_SOUND', !@soundIsOn

    openPortfolioWindow: ()->
      @$store.dispatch 'openPortfolio'
    openOverflowConsole: (overflowView)->
      @$store.dispatch 'openOverflowConsole', overflowView

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
  background-color: $window_background
  padding: 0 20px

  .logo
    +flexbox
    +align-items(row)
    +align-items(center)
    height: 40px
    img
      width: auto
      height: 100%

  .other-stuff
    +flexbox
    +align-items(row)
    +align-items(center)
    +justify-content(space-between)
    width: 300px
    +headerType(small)
    font-size: 13px
    text-transform: uppercase
    color: $action_red
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
      &:hover > span
        height: 30%
        opacity: .5
        +transition(.15s ease all)
      span
        opacity: .9
        height: 100%
        width: 3px
        background-color: $black_three_quarters
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
