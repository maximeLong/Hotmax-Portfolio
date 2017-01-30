<template>
  <div class="project-image" v-on:click="openOverlay()">

    <div class="overflow-container">
      <div class="image-container">
        <img :src="'../static/projects/' + banner"/>
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
    banner:       type: String
    orientation:  type: String

  methods:
    openOverlay: ()->
      overlay =
        title:        "#{@projectTitle} >> #{@banner}"
        orientation:  @orientation

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
  cursor: pointer
  border-bottom: 1px solid $window_border
  .caption
    padding: 30px 0
    font-style: italic
  .overflow-container
    position: relative
    &::before
      content: ''
      width: calc(100% - 10px)
      height: 100%
      display: block
      position: absolute
      right: -10px
      z-index: 9
      background: linear-gradient(transparentize($screen-background,1) 50%, transparentize(darken($screen-background,10),0.75) 50%), linear-gradient(90deg,transparentize(#ff0000,0.94),transparentize(#00ff00,0.98),transparentize(#0000ff,0.94))
      background-size: 100% 3px, 2px 100%
      pointer-events: none
  .image-container
    width: 100%
    max-height: 450px
    overflow: hidden
    img
      z-index: 99
      position: relative
      width: 100%
      height: auto



</style>
