<template>
  <div id="project-content">

    <div class="banner">
      <div class="portfolio-image">
        <img :src="'../static/banners/' + activeProjectWindow.meta.bannerImg">
      </div>
      <div class="title">{{activeProjectWindow.meta.realTitle}}</div>
    </div>

    <div class="content">
      <slot></slot>
    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'projectContent'

  computed:
    activeProjectWindow: -> return @$store.state.activeProjectWindow

</script>

<style lang="sass">
@import src/styles/main

#project-content

  .banner
    width: 100%
    height: 150px
    position: relative
    +flexbox
    +justify-content(middle)
    +align-items(center)
    .portfolio-image
      width: 100%
      height: 100%
      position: absolute
      overflow: hidden
      &::before
        content: ''
        display: block
        position: absolute
        top: 0
        left: 0
        bottom: 0
        right: 0
        background: linear-gradient(transparentize($screen-background,1) 50%, transparentize(darken($screen-background,10),0.75) 50%), linear-gradient(90deg,transparentize(#ff0000,0.94),transparentize(#00ff00,0.98),transparentize(#0000ff,0.94))
        z-index: 2
        background-size: 100% 3px, 2px 100%
        pointer-events: none
      img
        width: 100%
        height: 100%
    .title
      z-index: 99
      text-align: center
      margin: 0 auto
      background-color: $ink_black
      padding: 20px
      color: white

  .content
    padding: 30px
    height: calc(100% - 150px)
    width: 100%


</style>
