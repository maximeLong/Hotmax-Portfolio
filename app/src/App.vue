<template>
  <div id="app">

    <div id="entry-experience" v-if="entryIsOpen">
      <entry></entry>
    </div>

    <div id="desktop-experience" v-if="!entryIsOpen">
      <div id="header-container">
        <transition appear v-on:enter="startShowingStuff()" name="fadedown">
          <header-panel></header-panel>
        </transition>
      </div>

      <div id="body-container">
        <desktop-panel v-if="showDesktop"></desktop-panel>
        <console-panel v-if="showConsole"></console-panel>

        <div id="pdf-container" v-if="pdfIsOpen" v-bind:style="{ height: 'calc(' + pdfWindowHeight + '% - 60px)', width: pdfWindowWidth + '%' }">
          <pdf-panel></pdf-panel>
        </div>
      </div>

    </div>

    <button v-on:click="changeSpaceMode('desktop')">change mode</button>
    <div class="three-container">
      <div class="growth-container">
        <three :mode="spaceMode"></three>
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
    PdfPanel: require './components/PdfPanel'
    Three: require './components/Three'

  data: ->
    entryIsOpen: false
    showConsole: false
    showDesktop: false

    pdfWindowHeight: 90
    pdfWindowWidth: 70

    spaceMode: 'entry'

  mounted: ->
    @$watch 'activePdf', (pdf)->
      if pdf.title == 'readme.txt' || pdf.title == 'resume.txt'
        @pdfWindowHeight = 100
        @pdfWindowWidth = 50
      else
        @pdfWindowHeight = 90
        @pdfWindowWidth = 70

  computed:
    # vuex
    pdfIsOpen: -> return @$store.state.pdfIsOpen
    activePdf: ->  return @$store.state.activePdf

  methods:
    startShowingStuff: ->
      setTimeout =>
        @showDesktop = true
      , 1000
      setTimeout =>
        @showConsole = true
      , 3500
    changeSpaceMode: (newMode)->
      console.log 'space mode button click'
      @spaceMode = newMode


</script>

<style lang="sass">
@import src/styles/main

#app
  position: relative
  width: 100vw
  height: 100vh
  overflow: hidden

  button
    position: absolute
    top: 200px
    left: 200px
    z-index: 999999

  .three-container
    width: 100%
    height: 100%
    z-index: 9
    +flexbox
    +align-items(center)
    +justify-content(center)
    .growth-container
      width: 500px
      height: 500px
      border-radius: 100%
      background-color: $ink_black
      position: relative
      +flexbox
      +align-items(center)
      +justify-content(center)
      &::after
        content: ''
        position: absolute
        width: 108%
        height: 108%
        border-radius: 100%
        border: 2px solid $ink_black
      &::before
        content: ''
        position: absolute
        width: 100%
        height: 125px
        bottom: -125px
        background-image: url('assets/sisyphus-logo-small.svg')
        background-position: 50% 100%
        background-size: 100%
        background-repeat: no-repeat


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
    position: absolute
    top: 0
    left: 0
    height: 100vh
    width: 100vw
    overflow-x: hidden
    overflow-y: hidden
    #header-container
      height: 60px
    #body-container
      height: calc(100% - 60px)
      +flexbox
      +flex-direction(row)
      +align-content(center)
    #pdf-container
      position: absolute
      right: 0
      left: 0
      top: 0
      bottom: 0
      width: 60%
      min-width: 500px
      height: calc(100% - 60px)
      margin: 0 auto
      margin-top: 60px
      z-index: 999
      +flexbox
      +align-items(center)
      +justify-content(center)



</style>
