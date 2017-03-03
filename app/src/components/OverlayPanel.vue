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
    +screen(mobile)
      height: 100%

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
      +screen(mobile)
        padding: 30px 20px 40px 20px
      .title-container
        +flexbox
        +flex-direction(row)
        +align-items(center)
        +justify-content(space-between)
        .title
          +headerType(big)
        .link-container
          +headerType(small)
          +screen(mobile)
            display: none
          .link
            padding: 2px 0
            position: relative
            +clickable
            &::before
              content: ''
              display: block
              top: 50%
              left: -90%
              position: absolute
              height: 1px
              width: 70px
              background-color: white
              +screen(tablet)
                left: -50%
                width: 30px
      .introduction-container
        +defaultType(normal)
        color: white
        margin-top: 30px
        padding-left: 90px
        width: calc(100% - 150px)
        position: relative
        span
          color: $action_red
          +clickable
        +screen(tablet)
          width: 100%
          padding-left: 50px
        +screen(mobile)
          width: 100%
          padding-left: 0
        &::before
          content: ''
          display: block
          top: 12px
          left: 0
          position: absolute
          height: 2px
          width: 70px
          background-color: $action_red
          +screen(tablet)
            width: 30px
          +screen(mobile)
            display: none

    .service-panel
      background-color: white
      padding: 50px 40px 40px 40px
      +flexbox
      +align-items(flex-start)
      +screen(mobile)
        +flex-direction(column)
        +align-items(center)
        padding: 30px 20px 40px 20px
      .icon
        +flex(1 1 40%)
        min-width: 300px
        min-height: 200px
        +screen(mobile)
          max-width: 350px
      .panel-text
        +flex(1 1 60%)
        padding-left: 30px
        max-width: 900px
        +screen(mobile)
          width: 100%
          padding-left: 0
        .title
          +headerType(h2)
          color: #0b3039
          padding-bottom: 10px
          +screen(mobile)
            margin: 30px 0 5px 0
            text-align: center
        .text
          li
            padding-left: 30px
            margin: 5px 0
            font-size: 15px
            width: calc(100% - 30px)
            position: relative
            &::before
              +screen(mobile)
                width: 15px
              content: ''
              display: block
              top: 10px
              left: 0
              position: absolute
              height: 1px
              width: 20px
              background-color: $action_red

      //permutation
      &.reverse
        +flex-direction(row-reverse)
        +screen(mobile)
          +flex-direction(column)
        .panel-text
          padding-left: 0
          padding-right: 30px
          +screen(mobile)
            padding-right: 0px

      &.centered
        +flex-direction(column)
        +align-items(center)
        .title, .panel-text
          text-align: center
      &.contact
        margin-bottom: 30px
        +screen(mobile)
          padding-top: 10px
          margin-bottom: 20px
        .contact-link
          padding: 10px
          margin-top: 10px
          text-transform: uppercase
          letter-spacing: 3px
          font-size: 13px
          border: 1px solid $ink_black
          +clickable


</style>
