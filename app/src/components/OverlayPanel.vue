<template>
  <div id="overlay-panel">
    <window :canClose="true" :shortTitle="'::' + activeOverlay.title" :type="'overlay'">

      <div class="content">
        <img src="../assets/readme-image.png" v-if="activeOverlay.title !== 'asteroids.exe'">
      </div>

      <div class="asteroids-content" v-if="activeOverlay.title == 'asteroids.exe'">
        <asteroids></asteroids>
      </div>

    </window>
</template>

<script lang="coffee">
interact = require('interact.js')

module.exports =
  name: 'overlayPanel'
  components:
    Window: require './Window'
    Asteroids: require './Asteroids'

  computed:
    activeOverlay: -> return @$store.state.activeOverlay

  created: ->
    interact('#overlay-panel')
      .styleCursor(false)
      .draggable({
        inertia: true,
        restrict: {
          restriction: "#body-container",
          endOnly: true,
          elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
        }
        autoScroll: true,
        onmove: (event)->
          target = event.target
          x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
          y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
          target.style.webkitTransform = 'translate3d(' + x + 'px, ' + y + 'px, 0)'
          target.style.transform =       'translate3d(' + x + 'px, ' + y + 'px, 0)'
          target.setAttribute('data-x', x)
          target.setAttribute('data-y', y)
      })



</script>

<style lang="sass">
@import src/styles/main

#overlay-panel
  width: 100%
  height: 90%

  .content
    background-color: $black_one_quarter

  .asteroids-content
    height: 100%
    width: 100%
    padding: 25px
    background-color: $ink_black
    +flexbox

  .overlay
    .content
      padding: 0 30px
      img
        width: 100%



</style>
