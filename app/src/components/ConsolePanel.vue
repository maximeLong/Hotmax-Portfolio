<template>
  <div id="console-panel">
    <div class="console-container" v-bind:style="containerStyle">
      <window :canClose="overflowConsoleIsOpen ? true : false"
              :shortTitle="'::Console.exe'"
              :type="'consoleWindow'">

        <div class="console">

          <!-- default console -->
          <transition name="fadedown" appear>
            <intro-text v-if="showDefaultConsole"></intro-text>
          </transition>

          <!-- normalConsoleIsOpen -->
          <transition name="fadedown">
            <component v-bind:is="normalConsoleText.component" v-if="portfolioWindowIsOpen"></component>
            <component v-bind:is="normalConsoleText.readme" v-if="projectWindowIsOpen"></component>

          </transition>

          <!-- overflowConsoleIsOpen -->
          <!-- <transition name="consoletransition">
            <component
              v-bind:is="overflowConsoleText.component"
              v-if="overflowConsoleIsOpen">
            </component>
          </transition> -->



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

    # OurServices:    require './OurServices'
    # OurStory:       require './OurStory'
    # OurContact:     require './OurContact'

    PortfolioText:  require './PortfolioText'
    IntroText:      require './IntroText'

    DigitalTextbookReadme:  require '../projects/DigitalTextbook/DigitalTextbookReadme'
    VideoPortalReadme:      require '../projects/VideoPortal/VideoPortalReadme'
    WhereyaatReadme:        require '../projects/Whereyaat/WhereyaatReadme'
    ArSynthReadme:          require '../projects/ArSynth/ArSynthReadme'
    TranslationReadme:      require '../projects/Translation/TranslationReadme'
    WalkthroughReadme:      require '../projects/Walkthrough/WalkthroughReadme'


  mounted: ->
    @$watch 'overflowConsoleIsOpen', (val)->
      if val is true
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
    containerStyle:
      width: '79%'
      transform: 'translate3d(50px, 0, 0)'
      '-webkit-transform': 'translate3d(50px, 0, 0)'

  computed:
    showDefaultConsole: ->
      if @portfolioWindowIsOpen or @overflowConsoleIsOpen or @projectWindowIsOpen
        return false
      else return true

    normalConsoleIsOpen: ->     return @$store.state.normalConsoleIsOpen
    overflowConsoleIsOpen: ->   return @$store.state.overflowConsoleIsOpen
    normalConsoleText: ->       return @$store.state.normalConsoleText
    overflowConsoleText: ->     return @$store.state.overflowConsoleText

    portfolioWindowIsOpen: ->   return @$store.state.portfolioWindowIsOpen
    projectWindowIsOpen: ->     return @$store.state.projectWindowIsOpen
    activeProjectWindow: ->     return @$store.state.activeProjectWindow


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
        background-color: $action_red
      .title
        +headerType(normal)
    .content
      width: 100%
      .intro-title
        text-transform: uppercase
        color: $action_color
        font-weight: bold
        font-size: 15px
        letter-spacing: 3px
      .main-text
        margin: 10px 0 37px 0
        font-size: 18px
        line-height: 29px
        span
          +clickable
          text-decoration: underline
          color: $vapor_blue

        li
          padding: 4px 0
          position: relative
          padding-left: 17px
          &::before
            height: 100%
            position: absolute
            left: 0
            top: 4px
            content: '>'
            color: $action_color
            padding-right: 5px





</style>
