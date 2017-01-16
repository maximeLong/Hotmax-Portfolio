<template>
  <div id="console-panel">
    <div class="console-container">
      <window :canClose="false" :shortTitle="'::Sisyphus Console.exe'">
        <div class="console">

          <!-- entry experience -->
          <transition name="fadedown" appear>
            <div class="intro-top" v-if="!windowIsOpen && windowCount < 1">
              <!-- <div class="intro">Welcome back to work [ <span>MAXIME LONG</span> ].</div> -->
              <typed class="line"
                :str="'Welcome back to work [EMPLOYEE NAME || Maxime Long].'"
                :cleanCursor="true"
                :delay="2000"
                v-on:done="lineDone">
              </typed>
              <typed class="line"
                :str="'You have ' + taskNumber + ' overdue tasks assigned to your employment card.'"
                :cleanCursor="true"
                :delay="500"
                v-on:done="lineDone"
                v-if="sentenceIndex > 0">
              </typed>
              <typed class="line"
                :str="'Please contact your supervisor.'"
                :cleanCursor="true"
                :delay="500"
                v-on:done="lineDone"
                v-if="sentenceIndex > 1">
              </typed>
            </div>
          </transition>

          <!-- readme experience -->
          <typed class="inline"
            :str="'>'"
            :cleanCursor="windowIsOpen ? true : false"
            v-if="sentenceIndex > 2 || windowCount > 0"
          ></typed>
          <typed class="inline cd"
            :str="'CD ' + activeWindow.shortTitle + ' && RUN .README'"
            v-if="windowIsOpen">
          </typed>
          <transition name="fadedown">
            <div class="readme" v-if="windowIsOpen">
              {{activeWindow.shortTitle}}
            </div>
          </transition>

          <!-- aesthetic bottom -->
          <transition name="fadeup" appear>
            <div class="graphs" v-if="!windowIsOpen">
              version 1.7 -- copyright Sisyphus Mining Corporation
            </div>
          </transition>



        </div>
      </window>
  </div>
</template>

<script lang="coffee">
interact = require('interact.js')

module.exports =
  name: 'consolePanel'
  components:
    Window: require './Window'
    Typed: require './Typed'
    Ascii: require './Ascii'

  mounted: ->
    @$watch 'windowIsOpen', (newVal, oldVal)->
      if newVal is true then @windowCount = @windowCount + 1

  data: ->
    sentenceIndex: 0
    windowCount: 0

  computed:

    # vuex
    windowIsOpen: -> return @$store.state.windowIsOpen
    activeWindow: -> return @$store.state.activeWindow
    taskNumber: -> return Math.floor((Math.random() * 10000) + 1)


  methods:
    lineDone: ->
      @sentenceIndex += 1

  # created: ->
  #   interact('.console-container')
  #     .styleCursor(false)
  #     .draggable({
  #       inertia: true,
  #       restrict: {
  #         restriction: "#body-container",
  #         endOnly: true,
  #         elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
  #       }
  #       autoScroll: true,
  #       onmove: (event)->
  #         target = event.target
  #         x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
  #         y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
  #         target.style.webkitTransform = 'translate3d(' + x + 'px, ' + y + 'px, 0)'
  #         target.style.transform =       'translate3d(' + x + 'px, ' + y + 'px, 0)'
  #         target.setAttribute('data-x', x)
  #         target.setAttribute('data-y', y)
  #     })



</script>

<style lang="sass">
@import src/styles/main

#console-panel
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  // overflow: hidden

  .console-container
    width: 75%
    height: 80%
    z-index: 99
    position: relative

  .console
    padding: 30px
    color: white
    background-color: $console_black
    height: 100%
    width: 100%

    .intro-top
      margin-bottom: 20px
      .intro
        +systemType
        font-weight: normal
        font-size: 17px
        line-height: 20px
        letter-spacing: 3px
        color: white
        margin-bottom: 15px
        padding-bottom: 10px
        border-bottom: 1px solid white
        text-align: center
        span
          color: #4ad39e
          text-shadow: 0 0 7px #4ad39e
          font-weight: bold
      .line
        display: block
        margin: 10px 0
        text-transform: uppercase

    .cd
      &::first-letter
        margin-right: 5px

    .readme
      border: 1px solid white
      padding: 20px
      margin-top: 20px
    .graphs
      position: absolute
      bottom: 20px



</style>
