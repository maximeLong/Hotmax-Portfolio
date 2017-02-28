<template>
  <div id="logo-entry">

    <div class="entry-directions" :class="{ 'fade-out' : entryTimer != null }">

      <transition name="fadedelay" appear v-on:after-enter="emitLogoDone()">
        <div class="big-logo"></div>
      </transition>
      <transition name="fadeup">
        <!-- <div class="directions" v-if="logoDone">Press and hold [ <span>space</span> ] to log in.</div> -->
        <button id="thumbprint" v-if="logoDone">press this </button>

      </transition>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'logoEntry'
  props:
    entryTimer: default: null

  data: ->
    logoDone: false

  methods:
    emitLogoDone: ->
      @logoDone = true
      @$emit('logoDone')


</script>

<style lang="sass">
@import src/styles/main

#logo-entry

  .entry-directions
    position: absolute
    right: 0
    left: 0
    top: 0
    bottom: 0
    width: 50%
    min-width: 300px
    max-width: 700px
    height: 100%
    +translate3d(0,-50px,0)
    margin: 0 auto
    padding: 20px 0
    z-index: 9999
    +flexbox
    +align-items(center)
    +flex-direction(column)
    +justify-content(space-between)
    &.fade-out
      opacity: 0
      +transition(3s linear all)

    .big-logo
      margin-top: 30px
      width: 70%
      height: 200px
      z-index: 9999
      position: relative
      background-image: url('../assets/logo-big.png')
      background-size: contain
      background-position: 50% 50%
      background-repeat: no-repeat
      &::after
        content: 'hotmax Workstation v1.01'
        display: block
        position: absolute
        bottom: 30px
        width: 100%
        text-align: center
        +systemType
        color: white


    .directions
      border: 1px solid white
      padding: 15px 25px
      +systemType
      color: white
      background-color: rgba(0, 0, 0, 0.35)
      span
        // color: $action_color



</style>
