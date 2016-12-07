<template>
  <div id="console-panel">
    <div class="console-container">
      <window :canClose="false" :shortTitle="'::Bash Console.exe'">
        <div class="console">

          <typed class="line intro"
            :str="':/STATION_*͔̟̆ͪ#͓͎̞͚͎̜̭ͣ̄̓ͥ̓ͣ͠&̘̭͈̻̉̎̒ͣ̓͛͒̀*̸%̫͓̝̪̻̣̮̅ͥ̄͌ͯ#̢͇̰̳̰̬̼̀ͅ@̦̰̬̥̣́͂͗%̸̫͉̘͖̺͔͓́!̡ͨ͂̈́ / USERS / MAXIMELONG'"
            :type-speed="80"
            :cleanCursor="true"
            :delay="2000"
            v-on:done="lineDone">
          </typed>

          <typed class="inline"
            :str="'>'"
            :cleanCursor="windowIsOpen ? true : false"
            v-if="sentenceIndex > 0"
          ></typed>

          <typed class="inline cd"
            :str="'CD ' + activeWindow.shortTitle + ' && RUN .README'"
            v-if="windowIsOpen">
          </typed>

          <ascii></ascii>



        </div>
      </window>
  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'consolePanel'
  components:
    Window: require './Window'
    Typed: require './Typed'
    Ascii: require './Ascii'

  data: ->
    sentenceIndex: 0

  computed:
    # vuex
    windowIsOpen: -> return @$store.state.windowIsOpen
    activeWindow: -> return @$store.state.activeWindow


  methods:
    lineDone: ->
      @sentenceIndex += 1
      console.log 'sentence done'



</script>

<style lang="sass">
@import src/styles/main

#console-panel
  position: relative
  +flex(1 1 50%)
  +flexbox
  +justify-content(center)
  +align-items(center)
  overflow: hidden

  .console-container
    width: 75%
    height: 80%
    z-index: 99
    position: relative

  .console
    padding: 30px
    color: white
    background-color: #262626
    height: 100%
    width: 100%

    .line
      display: block
      margin: 20px 0
      text-transform: uppercase
    .cd
      // span:nth-last-of-type(1)
      //   color: $action_red
      &::first-letter
        margin-right: 5px



</style>
