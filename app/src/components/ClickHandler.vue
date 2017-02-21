<template>
  <div id="click-handler">
  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'clickHandler'

  mounted: ->
    window.addEventListener 'click', (e)->
      console.log e.screenX, e.screenY


  computed:
    webGlIsWorking: ->  return @$store.state.webGlIsWorking
    entryIndex: ->     return @$store.state.entryIndex
    soundIsOn:       -> return @$store.state.soundIsOn



</script>

<style lang="sass">
@import src/styles/main

</style>
