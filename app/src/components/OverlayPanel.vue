<template>
  <div id="overlay-panel" :class="{portrait: activeOverlay.orientation == 'portrait'}">
    <window :canClose="true" :shortTitle="'::' + activeOverlay.title" :type="'overlay'">

      <div class="asteroids-content" v-if="activeOverlay.title == 'asteroids.exe'">
        <asteroids></asteroids>
      </div>

      <!-- text overlay -->
      <div class="content" v-if="activeOverlay.type == 'text'">
        <component v-bind:is="activeOverlay.component"></component>
      </div>

      <!-- image overlay -->
      <div class="content" v-if="activeOverlay.type == 'image'"
           @click="closeOverlay">
        <img :src="'../static/projects/' + activeOverlay.image"/>
      </div>

      <!-- video overlay -->
      <div class="content" v-if="activeOverlay.type == 'video'" @click="closeOverlay">
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

    OurServices:    require './OurServices'
    OurStory:       require './OurStory'
    OurContact:     require './OurContact'

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

  .asteroids-content
    height: 100%
    width: 100%
    padding: 25px
    background-color: $ink_black
    +flexbox

  .overlay
    .content
      img, video
        cursor: url('../assets/exit.png'), auto
        width: 100%
        margin-bottom: -5px


  //main services and about features
  #our-services, #our-story, #our-contact
    .header-container
      padding: 30px 40px 50px 40px
      background-color: #0b3039
      .title-container
        +flexbox
        +flex-direction(row)
        +align-items(center)
        +justify-content(space-between)
        .title
          +headerType(big)
        .link-container
          +headerType(small)
          .link
            padding: 2px 0
            position: relative
            &::before
              content: ''
              display: block
              top: 50%
              left: -90%
              position: absolute
              height: 1px
              width: 70px
              background-color: white
      .introduction-container
        +defaultType(normal)
        color: white
        margin-top: 30px
        padding-left: 90px
        width: calc(100% - 150px)
        position: relative
        &::before
          content: ''
          display: block
          top: 12px
          left: 0
          position: absolute
          height: 2px
          width: 70px
          background-color: $action_red

    .service-panel
      background-color: white
      padding: 50px 40px 100px 40px
      +flexbox
      +align-items(flex-start)
      .icon
        +flex(1 1 40%)
      .panel-text
        +flex(1 1 60%)
        padding-left: 30px
        .title
          +headerType(h2)
          color: #0b3039
          padding-bottom: 10px


</style>
