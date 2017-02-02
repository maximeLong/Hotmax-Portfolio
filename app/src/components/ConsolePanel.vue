<template>
  <div id="console-panel">
    <div class="console-container" v-bind:style="containerStyle">
      <window :canClose="false" :shortTitle="'::Console.exe'">
        <div class="console">

          <!-- entry experience -->
          <transition name="fadedown" appear>
            <div class="intro-top" v-if="!projectWindowIsOpen && windowCount < 1">
              <typed class="line"
                :str="'Welcome [NEW EMPLOYEE] to the Afternoon Indians work terminal.'"
                :cleanCursor="true"
                :delay="1500"
                v-on:done="lineDone">
              </typed>
              <typed class="line"
                :str="'Please read through the company information at your leisure.'"
                :cleanCursor="true"
                :delay="0"
                v-on:done="lineDone"
                v-if="sentenceIndex > 0">
              </typed>
              <typed class="line"
                :str="'Contact a supervisor on completion, you have [' + taskNumber + '] tasks waiting.'"
                :cleanCursor="true"
                :delay="0"
                v-on:done="lineDone"
                v-if="sentenceIndex > 1">
              </typed>
            </div>
          </transition>

          <typed class="inline"
            :str="'>'"
            :cleanCursor="projectWindowIsOpen || consoleTextIsOpen ? true : false"
            v-if="sentenceIndex > 2 || windowCount > 0"
          ></typed>


          <!-- project readme -->
          <typed class="inline cd"
            :str="'OPEN [' + activeProjectWindow.meta.shortTitle + '] && Run .README'"
            :delay="0"
            :cleanCursor="true"
            v-if="projectWindowIsOpen">
          </typed>
          <transition name="fadedown">
            <component
              v-bind:is="activeProjectWindow.readme"
              v-if="projectWindowIsOpen">
            </component>
          </transition>

          <!-- our info -->
          <typed class="inline cd"
            :str="'OPEN [' + activeConsoleText.title + '] && Run .README'"
            :delay="0"
            :cleanCursor="true"
            v-if="consoleTextIsOpen && !projectWindowIsOpen">
          </typed>
          <transition name="fadedown">
            <component
              v-bind:is="activeConsoleText.component"
              v-if="consoleTextIsOpen && !projectWindowIsOpen">
            </component>
          </transition>


          <!-- aesthetic bottom -->
          <transition name="fadeup" appear>
            <div class="graphs" v-if="!projectWindowIsOpen && !consoleTextIsOpen">
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
    Typed:  require './Typed'
    Ascii:  require './Ascii'

    #our information components
    OurServices:  require './OurServices'
    OurStory:     require './OurStory'
    OurContact:   require './OurContact'

    #project components
    DigitalTextbookReadme:  require '../projects/DigitalTextbook/DigitalTextbookReadme'
    VideoPortalReadme:      require '../projects/VideoPortal/VideoPortalReadme'
    WhereyaatReadme:        require '../projects/Whereyaat/WhereyaatReadme'
    IbesReadme:             require '../projects/Ibes/IbesReadme'
    ArSynthReadme:          require '../projects/ArSynth/ArSynthReadme'
    TranslationReadme:      require '../projects/Translation/TranslationReadme'
    WalkthroughReadme:      require '../projects/Walkthrough/WalkthroughReadme'


  mounted: ->
    @containerWidth = '79%'
    @containerX =     '50px'

    @$watch 'projectWindowIsOpen', (newVal, oldVal)->
      if newVal is true then @windowCount = @windowCount + 1
    @$watch 'consoleTextIsOpen', (newVal, oldVal)->
      if newVal is true
        @windowCount = @windowCount + 1

        @containerStyle =
          width: '95%'
          transform: 'translate3d(-40px, 0, 0)'
          '-webkit-transform': 'translate3d(-40px, 0, 0)'
      else

        @containerStyle =
          width: '79%'
          transform: 'translate3d(50px, 0, 0)'
          '-webkit-transform': 'translate3d(50px, 0, 0)'


  data: ->
    sentenceIndex: 0
    windowCount: 0

    containerStyle:
      width: '79%'
      transform: 'translate3d(50px, 0, 0)'
      '-webkit-transform': 'translate3d(50px, 0, 0)'

  computed:
    consoleTextIsOpen: -> return @$store.state.consoleTextIsOpen
    activeConsoleText: -> return @$store.state.activeConsoleText
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
    width: 79%
    height: 80%
    +translate3d(50px,0,0)
    +transition(.35s ease all)
    z-index: 999
    position: relative

  .console
    padding: 30px
    color: white
    background-color: $console_black
    height: 100%
    width: 100%

    //console features shared
    .header-container
      padding: 30px 0
      margin-bottom: 10px
      &::after
        content: ''
        display: block
        margin-top: 20px
        width: 100px
        height: 9px
        background-color: white
      .title
        +showyType
        color: white
        line-height: 55px
    .content
      width: 100%

    // intro and aesthetic features
    .intro-top
      margin-bottom: 20px
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
