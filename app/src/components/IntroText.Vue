<template>
  <div id="intro-text">

    <typed class="line header"
      :str="'Hotmax'"
      :cleanCursor="true"
      :delay="secondTime ? 500 : 1500"
      :cursorChar="'_'"
      :typeSpeed="100"
      v-on:done="lineDone">
    </typed>
    <typed class="line header"
      :str="'Interactive'"
      :cleanCursor="true"
      :delay="100"
      :cursorChar="'_'"
      :typeSpeed="100"
      v-on:done="lineDone"
      v-if="sentenceIndex > 0">
    </typed>
    <typed class="line header"
      :str="'Studio.'"
      :cleanCursor="true"
      :cursorChar="'_'"
      :delay="200"
      :typeSpeed="100"
      v-on:done="lineDone"
      v-if="sentenceIndex > 1">
    </typed>

    <!-- secondary stuff -->
    <transition appear v-on:enter="lineDone" name="fadedown">
      <div class="bar"
        v-if="sentenceIndex > 2">
      </div>
    </transition>

    <typed class="line consoleStyle"
      :str="'Loading: hotmax'"
      :cleanCursor="true"
      :cursorChar="'_'"
      :delay="500"
      :typeSpeed="75"
      v-on:done="lineDone"
      v-if="sentenceIndex > 3">
    </typed>
    <typed class="line consoleStyle"
      :str="'Profile: [guest]'"
      :cleanCursor="true"
      :cursorChar="'_'"
      :delay="500"
      :typeSpeed="75"
      v-on:done="lineDone"
      v-if="sentenceIndex > 4">
    </typed>
    <typed class="line consoleStyle"
      :str="'Connect: [========================]'"
      :cleanCursor="true"
      :cursorChar="'_'"
      :delay="500"
      :typeSpeed="75"
      v-on:done="lineDone"
      v-if="sentenceIndex > 5">
    </typed>
    <typed class="line consoleStyle"
      :str="'Success! Site Map Loaded:'"
      :cleanCursor="false"
      :cursorChar="'_'"
      :delay="500"
      :typeSpeed="75"
      v-on:done="lineDone"
      v-if="sentenceIndex > 6">
    </typed>

    <transition name="fadedown" v-on:enter="mouseListen">
      <div class="siteMap" v-if="sentenceIndex > 7">

        <div class="line consoleStyle">Select destination with [arrow keys] and [enter]</div>
        <div class="line consoleStyle" :class="{ active : mapIndex == 0 }">1. Hotmax Work </div>
        <div class="line consoleStyle" :class="{ active : mapIndex == 1 }">2. Hotmax Services</div>
        <div class="line consoleStyle" :class="{ active : mapIndex == 2 }">3. About Hotmax</div>
        <div class="line consoleStyle" :class="{ active : mapIndex == 3 }">4. Contact Hotmax</div>

      </div>
    </transition>





  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'introText'
  components:
    Typed: require './Typed'

  props:
    secondTime: type: Boolean
  data: ->
    sentenceIndex: 0
    mapIndex: 0

  mounted: ->
    @$emit('done')

  computed:
    consoleTexts: -> return @$store.state.consoleTexts


  methods:
    lineDone: ->
      @sentenceIndex += 1
    mouseListen: ->
      document.addEventListener 'keyup', (event)=>
        keyName = event.key

        if keyName is 'ArrowUp' and @mapIndex > 0
          @mapIndex -= 1
          console.log @mapIndex
        if keyName is 'ArrowDown' and @mapIndex < 3
          @mapIndex += 1
          console.log @mapIndex
        if keyName is 'Enter'
          @openLink(@mapIndex)
      , false

    openLink: (index)->
      switch index
        when 0 then @$store.dispatch 'openPortfolio'
        when 1 then @$store.dispatch 'openOverflowConsole', @consoleTexts.ourServices
        when 2 then @$store.dispatch 'openOverflowConsole', @consoleTexts.aboutUs
        when 3 then @$store.dispatch 'openOverflowConsole', @consoleTexts.contactUs

</script>

<style lang="sass">
@import src/styles/main

#intro-text
  margin-bottom: 20px
  .line
    margin: 10px 0
    display: block
    &.header
      +showyType
      color: white
      letter-spacing: 3px
    &.consoleStyle
      +consoleHeader
      font-style: none
      font-size: 20px
      color: white

  .bar
    display: block
    margin: 30px 0
    width: 30%
    height: 9px
    background-color: $action_red

  .siteMap
    margin-top: 20px
    position: relative
    width: 100%
    border: 2px solid white
    padding: 10px 30px
    .line:first-of-type
      margin-bottom: 20px
    .active
      color: $vapor_blue
      text-decoration: underline


</style>
