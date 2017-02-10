<template>
  <div id="overlay-panel" :class="{portrait: activeOverlay.orientation == 'portrait'}">
    <window :canClose="true" :shortTitle="'::' + activeOverlay.title" :type="'overlay'">

      <div class="asteroids-content" v-if="activeOverlay.title == 'asteroids.exe'">
        <asteroids></asteroids>
      </div>


      <div class="content" v-if="activeOverlay.type == 'image'"
           @click="closeOverlay">
        <img :src="'../static/projects/' + activeOverlay.image"/>
      </div>

      <div class="content" v-if="activeOverlay.type == 'video'">
        <video controls autoplay="true">
          <source :src="'../static/projects/' + activeOverlay.video" type="video/mp4">
          Get a better browser, we living in the fast lane.
        </video>
      </div>

    </window>
</template>

<script lang="coffee">

module.exports =
  name: 'overlayPanel'
  components:
    Window:       require './Window'
    Asteroids:    require './Asteroids'

  computed:
    activeOverlay: -> return @$store.state.activeOverlay

  methods:
    closeOverlay: ->
      @$store.commit 'SET_OVERLAY_IS_OPEN', false


</script>

<style lang="sass">
@import src/styles/main

#overlay-panel
  width: 100%
  &.portrait
    height: 90%

  .content
    background-color: $black_one_quarter
    cursor: url('../assets/exit.png'), auto

  .asteroids-content
    height: 100%
    width: 100%
    padding: 25px
    background-color: $ink_black
    +flexbox

  .overlay
    .content
      padding: 0 30px
      img, video
        width: 100%



</style>
