<template>
  <div id="entry">

  <!-- <div class="type-container">
    <div class="inline-container">Loading: [ </div>
    <div class="inline-container">

      <transition name="fadeup" >
        <div class="line intro" v-if="loadingDone">Success!</div>
        <typed class="line intro"
          :str="'hotmax'"
          :type-speed="620"
          :cleanCursor="true"
          :cursorChar="'_'"
          :delay="1000"
          v-if="!loadingDone"
          v-on:done="typeComplete">
        </typed>
      </transition>

    </div>
    <div class="inline-container"> ]</div>
  </div>

  <div class="triangle" :class="{ 'rotate-off': loadingDone }"></div> -->

  <button @click="setEntryIndex(1)">on</button>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'entry'
  components:
    Typed: require './Typed'
    Three: require './Three'

  # mounted: ->
  #   setTimeout =>
  #     @setEntryIndex(1)
  #   , 2000

  data: ->
    loadingDone: false
  methods:
    typeComplete: ->
      @loadingDone = true

    setEntryIndex: (index)-> @$store.commit 'SET_ENTRY_INDEX', index
    toggleSound: -> @$store.commit 'TOGGLE_SOUND', !@soundIsOn


  computed:
    webGlIsWorking: ->  return @$store.state.webGlIsWorking
    entryIndex: ->      return @$store.state.entryIndex
    soundIsOn: ->       return @$store.state.soundIsOn



</script>

<style lang="sass">
@import src/styles/main

@keyframes rotate
  0%
    +rotate(0)
  100%
    +rotate(90, 50, 50)

#entry
  background-color: white
  +defaultType(normal)
  color: white
  width: 50%
  +flexbox
  +align-items(center)
  +flex-direction(column)
  .type-container
    height: 50px
    font-size: 18px
    +flexbox
    +align-items(center)
    +flex-direction(row)
    .intro
      padding: 0 20px


  .triangle
    // border: 1px solid white
    margin-top: 100px
    height: 100px
    width: 100px
    background-image: url('../assets/logo-triangle.svg')
    background-size: 75%
    background-repeat: no-repeat
    background-position: 50% 25%
    animation: rotate 5s linear infinite
    position: relative
    &::after
      content: ''
      width: 5px
      height: 5px
      position: absolute
      top: 50%
      left: 50%
      background-color: #ed1a61
      +translateXY(-50%, -50%)
      +transition(1s ease all)

    &.rotate-off
      &::after
        width: 100px
        height: 100px
        border-radius: 100%
        background-color: #ed1a61
        +transition(1s ease all)






  .choice-container
    width: 50%
    min-width: 350px
    opacity: 0
    +transition(2s linear opacity)
    &.no-opacity
      opacity: 1
    .choice
      font-size: 18px
      +clickable
      color: $action_color
      padding: 4px 0
      &::before
        content: 'x'
        padding-right: 20px

  .terminal-container
    margin-top: 30px
    height: 300px
    width: 300px
    opacity: 0
    position: relative
    +transition(2s linear all)
    &.no-opacity
      opacity: 1
    .terminal-lines
      height: 100%
      width: 100%
      background-image: url('../assets/terminal.svg')
      background-size: 100%
      background-repeat: no-repeat
      background-position: 50% 50%
    .terminal-type
      position: absolute
      top: 50%
      left: 50%
      +translateXY(-50%, calc(-50% - 30px))
      .line
        font-size: 22px
        opacity: .7





</style>
