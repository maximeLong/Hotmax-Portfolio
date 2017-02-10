<template>
  <div class="project-image">

    <div class="overflow-container" v-on:click="openOverlay()">
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
  margin-bottom: 40px
  border-bottom: 1px solid $window_border
  &:last-of-type
    margin-bottom: 0
  .caption
    padding: 25px 0
    font-style: italic
  .overflow-container
    position: relative
    cursor: pointer

    &::before
      content: ''
      width: calc(100% + 10px)
      height: 100%
      display: block
      position: absolute
      right: -10px
      background: linear-gradient(transparentize($screen-background,1) 50%, transparentize(darken($screen-background,10),0.75) 50%), linear-gradient(90deg,transparentize(#ff0000,0.94),transparentize(#00ff00,0.98),transparentize(#0000ff,0.94))
      background-size: 100% 3px, 2px 100%
      pointer-events: none
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
        opacity: .6
        +transition(.35s ease all)

  .image-container
    width: 100%
    max-height: 450px
    overflow: hidden
    opacity: 1
    border: 3px solid $ink_black
    +transition(.35s ease all)
    &:hover
      opacity: .8
      // border: 3px solid $action_color
      +transition(.35s ease all)
    img
      z-index: 99
      position: relative
      width: 100%
      height: auto



</style>
