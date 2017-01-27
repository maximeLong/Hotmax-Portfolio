<template>
  <div id="console-panel">
    <div class="console-container">
      <window :canClose="false" :shortTitle="'::Console.exe'">
        <div class="console">

          <!-- entry experience -->
          <transition name="fadedown" appear>
            <div class="intro-top" v-if="!projectWindowIsOpen && windowCount < 1">
              <!-- <div class="intro">Welcome back to work [ <span>MAXIME LONG</span> ].</div> -->
              <typed class="line"
                :str="'Welcome [NEW EMPLOYEE] to the Afternoon Indians work terminal.'"
                :cleanCursor="true"
                :delay="2000"
                v-on:done="lineDone">
              </typed>
              <typed class="line"
                :str="'Please read through the company information at your leisure.'"
                :cleanCursor="true"
                :delay="500"
                v-on:done="lineDone"
                v-if="sentenceIndex > 0">
              </typed>
              <typed class="line"
                :str="'Contact a supervisor on completion, you have [' + taskNumber + '] tasks waiting.'"
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
            :cleanCursor="projectWindowIsOpen ? true : false"
            v-if="sentenceIndex > 2 || windowCount > 0"
          ></typed>
          <typed class="inline cd"
            :str="'CD ' + activeProjectWindow.meta.shortTitle + ' && RUN .README'"
            v-if="projectWindowIsOpen">
          </typed>
          <transition name="fadedown">

            <component
              v-bind:is="activeProjectWindow.readme"
              v-if="projectWindowIsOpen">
            </component>

          </transition>


          <!-- aesthetic bottom -->
          <transition name="fadeup" appear>
            <div class="graphs" v-if="!projectWindowIsOpen">
              version 1.7 -- copyright Afternoon Indians
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

    #project components
    DigitalTextbookReadme: require '../projects/DigitalTextbook/DigitalTextbookReadme'
    VideoPortalReadme: require '../projects/VideoPortal/VideoPortalReadme'


  mounted: ->
    @$watch 'projectWindowIsOpen', (newVal, oldVal)->
      if newVal is true then @windowCount = @windowCount + 1

  data: ->
    sentenceIndex: 0
    windowCount: 0

  computed:

    # vuex
    projectWindowIsOpen: -> return @$store.state.projectWindowIsOpen
    activeProjectWindow: -> return @$store.state.activeProjectWindow
    taskNumber: -> return Math.floor((Math.random() * 10000) + 1)


  methods:
    lineDone: ->
      @sentenceIndex += 1

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

    .graphs
      position: absolute
      bottom: 20px



</style>
