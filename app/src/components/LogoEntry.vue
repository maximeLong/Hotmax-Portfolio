<template>
  <div id="logo-entry">

    <div class="entry-directions" :class="{ 'fade-out' : entryTimer != null }">

      <transition name="fadedelay" appear v-on:after-enter="listenForEntryPress">
        <div class="big-logo" v-if="port != 'mobile'"></div>
      </transition>

      <transition name="fadedown" appear v-on:after-enter="listenForEntryPress">
        <intro-text v-if="port == 'mobile'"></intro-text>
      </transition>

      <transition name="fadeup" v-on:after-enter="attachMobileListeners">
        <div class="directions" v-if="logoDone && port == 'desktop'">Press and hold [ <span>space</span> ] to log in.</div>
        <div class="directions mobile" v-if="logoDone && port != 'desktop'">
          <button class="thumb" ref="thumbprint" id="thumbprint"></button>
          <div>Please scan your thumb to login</div>
        </div>
      </transition>

    </div>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'logoEntry'
  components:
    IntroText: require './IntroText'

  data: ->
    logoDone:   false
    entryTimer: null

  methods:
    listenForEntryPress: ->
      @logoDone = true
      if @port is 'desktop'
        window.addEventListener 'keydown', (e)=>
          @introDownEvent(e, 'key')
        window.addEventListener 'keyup', (e)=>
          @introUpEvent(e, 'key')

    attachMobileListeners: ->
      if @port != 'desktop'
        @$refs.thumbprint.addEventListener 'touchstart', (e)=>
          @introDownEvent(e, 'touch')
        @$refs.thumbprint.addEventListener 'touchend', (e)=>
          @introUpEvent(e, 'touch')
        @$refs.thumbprint.addEventListener 'mousedown', (e)=>
          @introDownEvent(e, 'touch')
        @$refs.thumbprint.addEventListener 'mouseup', (e)=>
          @introUpEvent(e, 'touch')


    introDownEvent: (e, type)->
      if @entryIndex is 1
        if (type is 'touch' and @port is 'mobile') #mobile handle
          @$emit('done')

        if (type is 'key' and e.keyCode is 32) or (type is 'touch' and @port is 'tablet') #desktop and tablet handle
          @$store.commit 'SET_THREE_GLITCH', true
          if @entryTimer is null
            @entryTimer =
              setTimeout =>
                @$emit('done')
              , 3000
    introUpEvent: (e, type)->
      if @entryIndex is 1
        if (type is 'key' and e.keyCode is 32) or type is 'touch'
          @$store.commit 'SET_THREE_GLITCH', false
          clearTimeout(@entryTimer)
          @entryTimer = null


  computed:
    port: ->        return @$store.state.port
    entryIndex: ->  return @$store.state.entryIndex

  destroyed: ->
    if @port is 'desktop'
      window.removeEventListener 'keydown', (e) => console.log('im removed')
      window.removeEventListener 'keyup', (e) => console.log('im removed')
    if @port != 'desktop'
      @$refs.thumbprint.removeEventListener 'touchstart', (e) => console.log('im removed')
      @$refs.thumbprint.removeEventListener 'touchend', (e) => console.log('im removed')
      @$refs.thumbprint.removeEventListener 'mousedown', (e) => console.log('im removed')
      @$refs.thumbprint.removeEventListener 'mouseup', (e) => console.log('im removed')


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
    +translateXY(0,-50px)
    margin: 0 auto
    padding: 20px 0
    z-index: 9999
    +flexbox
    +align-items(center)
    +flex-direction(column)
    +justify-content(space-between)
    +screen(mobile)
      +translateXY(0,0)
      width: 100%
      padding: 20px
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
        content: 'hotmax Operating System V1.01'
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
      z-index: 9999
      &.mobile
        text-align: center
        border: none
        button
          width: 75px
          height: 75px
          background-color: transparent
          outline: none
          border: none
          background-position: 50% 50%
          background-size: 100% 100%
          background-repeat: no-repeat
          background-image: url('../assets/thumbprint.svg')
          +clickable
        div
          margin-top: 20px



</style>
