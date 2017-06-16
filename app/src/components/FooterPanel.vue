<template>
  <div id="footer-panel">
    <div class="logo">
      <img src="../assets/logo-triangle-small.png">
    </div>
    <div class="other-stuff">
      <div class="work" @click="openPortfolioWindow()">:file</div>
      <div class="about"@click="openOverlay(consoleTexts.ourServices)">:help</div>
    </div>
    <div class="sound" @click="toggleSound">
      <span v-for="i in 5" :class="{soundOn: soundIsOn, soundOff: !soundIsOn}"></span>
    </div>
    <div class="logo-middle">
      <img src="../assets/logo-text-small.png">
    </div>
  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'footerPanel'

  computed:
    soundIsOn: ->             return @$store.state.soundIsOn
    consoleTexts:     ->      return @$store.state.consoleTexts

  methods:
    toggleSound: ->
      @$store.commit 'TOGGLE_SOUND', !@soundIsOn

    openPortfolioWindow: ()->
      @$store.dispatch 'openPortfolio'
    openOverlay: (view)->
      overlay = view
      overlay.orientation = 'portrait'
      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', view

</script>

<style lang="sass">
@import src/styles/main

#footer-panel
  position: relative
  width: 100%
  height: 100%
  z-index: 9999
  +flexbox
  +align-items(center)
  +flex-direction(row)
  +justify-content(space-between)
  background-color: black
  padding: 0 40px
  +screen(mobile)
    padding: 0 20px

  .logo
    cursor: pointer
    height: 30px
    margin-right: 20px
    img
      width: auto
      height: 100%
  .logo-middle
    position: absolute
    left: 50%
    top: 50%
    height: 17px
    +translateXY(-50%, -50%)
    +screen(mobile)
      display: none
    img
      width: auto
      height: 100%

  .other-stuff
    +flexbox
    +align-items(row)
    +align-items(center)
    width: 300px
    +headerType(small)
    font-size: 13px
    text-transform: uppercase
    color: white
    .about, .work
      padding: 0 15px
      cursor: pointer
  .sound
    cursor: pointer
    width: 30px
    height: 20px
    margin-left: auto
    +flexbox
    +flex-direction(row)
    +align-items(flex-end)
    +justify-content(space-between)
    +rotate(-90deg)
    &:hover > span
      height: 30%
      opacity: .5
      +transition(.15s ease all)
    span
      opacity: .9
      height: 100%
      width: 2px
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
