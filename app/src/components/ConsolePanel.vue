<template>
  <div id="console-panel">
    <div class="console-container" v-bind:style="containerStyle">
      <window :canClose="false" :shortTitle="'::Console.exe'" :type="'consoleWindow'">

        <div class="console">

          <!-- entry experience -->
          <transition name="fadedown" appear>
            <intro-text
              v-if="!hideIntro"
              v-on:done="introDone = true">
            </intro-text>
          </transition>

          <!-- standby line -->
          <!-- TODO: blow this up into something interesting -->
          <transition name="consoletransition">
            <typed class="inline"
              :str="'>'"
              :cleanCursor="projectWindowIsOpen || consoleTextIsOpen ? true : false"
              v-if="introDone && !projectWindowIsOpen && !consoleTextIsOpen"
            ></typed>
          </transition>

          <!-- project window -->
          <transition name="fadedown">
            <component
              v-bind:is="activeProjectWindow.readme"
              v-if="projectWindowIsOpen">
            </component>
          </transition>

          <!-- consoleText component -->
          <transition name="consoletransition">
            <component
              v-bind:is="activeConsoleText.component"
              v-if="consoleTextIsOpen && !projectWindowIsOpen">
            </component>
          </transition>


          <!-- aesthetic bottom -->
          <transition name="fadeup" appear>
            <div class="graphs" v-if="!projectWindowIsOpen && !consoleTextIsOpen">
              version 1.7 -- copyright hotmax interactive division
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
    Window:     require './Window'
    Typed:      require './Typed'
    IntroText:  require './IntroText'
    OurServices:    require './OurServices'
    OurStory:       require './OurStory'
    OurContact:     require './OurContact'
    DigitalTextbookReadme:  require '../projects/DigitalTextbook/DigitalTextbookReadme'
    VideoPortalReadme:      require '../projects/VideoPortal/VideoPortalReadme'
    WhereyaatReadme:        require '../projects/Whereyaat/WhereyaatReadme'
    IbesReadme:             require '../projects/Ibes/IbesReadme'
    ArSynthReadme:          require '../projects/ArSynth/ArSynthReadme'
    TranslationReadme:      require '../projects/Translation/TranslationReadme'
    WalkthroughReadme:      require '../projects/Walkthrough/WalkthroughReadme'


  mounted: ->
    @$watch 'projectWindowIsOpen', (newVal, oldVal)->
      if newVal is true then @hideIntro = true #hide intro after first open

    @$watch 'consoleTextIsOpen', (newVal, oldVal)->
      if newVal is true #hide intro after first open
        @hideIntro = true
        @containerStyle =
          width: '100%'
          transform: 'translate3d(-55px, 0, 0)'
          '-webkit-transform': 'translate3d(-55px, 0, 0)'
      else
        @containerStyle =
          width: '79%'
          transform: 'translate3d(50px, 0, 0)'
          '-webkit-transform': 'translate3d(50px, 0, 0)'

  data: ->
    hideIntro: false
    introDone: false
    containerStyle:
      width: '79%'
      transform: 'translate3d(50px, 0, 0)'
      '-webkit-transform': 'translate3d(50px, 0, 0)'

  computed:
    consoleTextIsOpen: -> return @$store.state.consoleTextIsOpen
    activeConsoleText: -> return @$store.state.activeConsoleText
    projectWindowIsOpen: -> return @$store.state.projectWindowIsOpen
    activeProjectWindow: -> return @$store.state.activeProjectWindow


  methods:
    startWipe: ->
      @wipeScreen = true
      setTimeout =>
        @wipeScreen = false
      , 750

</script>

<style lang="sass">
@import src/styles/main

#console-panel
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  height: 100%
  // overflow: hidden

  .console-container
    width: 79%
    height: 80%
    +translate3d(50px,0,0)
    +transition(.35s ease all)
    z-index: 999
    position: relative
    // &::after
    //   opacity: .7
    //   position: absolute
    //   left: 0
    //   top: 0
    //   content: ''
    //   display: block
    //   height: 100%
    //   width: 100%
    //   background-image: url('../assets/console-grad.png')
    //   background-position: 0% 0%
    //   background-size: 100%
    //   background-repeat: no-repeat

  .console
    padding: 30px
    color: white
    background-color: $console_black
    height: 100%
    width: 100%
    position: relative

    //console features shared
    .header-container
      padding: 20px 0 30px 0
      margin-bottom: 10px
      &::after
        content: ''
        display: block
        margin-top: 20px
        width: 100px
        height: 9px
        background-color: #e45f60
      .title
        +showyType
        color: white
        line-height: 55px
    .content
      width: 100%


    .graphs
      position: absolute
      bottom: 20px



</style>
