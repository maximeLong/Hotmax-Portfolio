<template>
  <div id="app">
    
    <div id="header-container">
      <header-panel></header-panel>
    </div>
    <div id="body-container">
      <desktop-panel></desktop-panel>
      <console-panel></console-panel>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =

  name: 'app'
  components:
    DesktopPanel: require './components/DesktopPanel'
    ConsolePanel: require './components/ConsolePanel'
    HeaderPanel: require './components/HeaderPanel'



</script>

<style lang="sass">
@import src/styles/main

#app
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
