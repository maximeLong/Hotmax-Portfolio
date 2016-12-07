<template>
  <div id="app">

    <div id="entry-experience" v-if="entryIsOpen">
      <entry></entry>
    </div>

    <div id="desktop-experience" v-if="!entryIsOpen">
      <div id="header-container">
        <header-panel></header-panel>
      </div>
      <div id="body-container">
        <desktop-panel></desktop-panel>
        <console-panel></console-panel>
        <!-- <three></three> -->
        <!-- <crt></crt> -->
      </div>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =

  name: 'app'
  components:
    Entry: require './components/Entry'
    DesktopPanel: require './components/DesktopPanel'
    ConsolePanel: require './components/ConsolePanel'
    HeaderPanel: require './components/HeaderPanel'

    Three: require './components/Three'
    Crt: require './components/Crt'
    Ascii: require './components/Ascii'

  data: ->
    entryIsOpen: true


</script>

<style lang="sass">
@import src/styles/main

#app
  #entry-experience
    +defaultType
    color: white
    height: 100vh
    width: 100vw
    overflow-x: hidden
    overflow-y: hidden
    +flexbox
    +flex-direction(column)
    +align-items(center)
    +justify-content(center)
    background-color: black
  #desktop-experience
    +defaultType
    height: 100vh
    width: 100vw
    overflow-x: hidden
    overflow-y: hidden
    #header-container
      height: 40px
    #body-container
      height: calc(100% - 40px)
      +flexbox
      +flex-direction(row)
      +align-content(center)


</style>
