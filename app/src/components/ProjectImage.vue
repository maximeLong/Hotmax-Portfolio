<template>
  <div class="project-image">

    <div class="overflow-container" v-on:click="openOverlay()" :class="type">
      <div class="image-container">
        <img :src="'../static/projects/' + imageUrl"/>
      </div>
    </div>

    <div class="caption">
      <slot></slot>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'projectImage'

  props:
    imageUrl:     type: String
    videoUrl:     type: String
    orientation:  type: String
    type:       { type: String, default: 'image' }

  methods:
    openOverlay: ()->
      overlay =
        title:        "#{@projectTitle} >> #{if @type is 'image' then @imageUrl else @videoUrl }"
        orientation:  @orientation
        type:         @type

      if @type is 'image' then overlay.image = @imageUrl
      if @type is 'video' then overlay.video = @videoUrl

      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', overlay

  computed:
    projectTitle: -> return @$store.state.activeProjectWindow.meta.shortTitle



</script>

<style lang="sass">
@import src/styles/main

.project-image
  width: 100%
  margin-bottom: 20px
  border-bottom: 1px solid $window_border
  +screen(mobile)
    margin-bottom: 10px
  &:last-of-type
    margin-bottom: 0
  .caption
    padding: 10px 0
    font-style: italic
    +screen(mobile)
      padding: 5px
  .overflow-container
    position: relative
    cursor: pointer
    &.video
      position: relative
      &::after
        content: ''
        height: 8vw
        width: 16%
        display: block
        position: absolute
        top: 50%
        left: 50%
        +translateXY(-50%,-50%)
        z-index: 999
        opacity: 0
        background-image: url('../assets/video.svg')
        background-repeat: no-repeat
        background-size: cover
        background-position: 50% 50%
        +transition(.35s ease all)

    &::after
      content: '+'
      color: white
      font-size: 30px
      padding: 8px 15px
      display: block
      position: absolute
      bottom: 10px
      left: 10px
      z-index: 999
      opacity: 0
      background-color: $action_color
      +transition(.35s ease all)
    &:hover
      &::after
        opacity: .7
        +transition(.35s ease all)


  .image-container
    width: 100%
    max-height: 450px
    overflow: hidden
    opacity: 1
    border: 2px solid $ink_black
    +transition(.35s ease all)
    &:hover
      opacity: .8
      +transition(.35s ease all)
      +screen(mobile)
        opacity: 1
    img
      z-index: 99
      position: relative
      width: 100%
      height: auto



</style>
