<template>
  <div id="project-content">

    <div class="banner">

      <div class="logo"></div>

      <transition appear name="fadeup">
        <div class="info-container">
          <div class="title">{{activeProjectWindow.meta.realTitle}}</div>
          <div class="client">{{activeProjectWindow.meta.client}}</div>
        </div>
      </transition>

      <div class="image-mega-container">
        <div class="image-container">
          <!-- <img :src="'../static/banners/' + activeProjectWindow.meta.bannerImg"> -->
        </div>
      </div>

      <div class="date">Completed >> {{activeProjectWindow.meta.date}}</div>


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

@keyframes flicker
  $steps: 20
  @for $i from 0 through $steps
    #{percentage($i*(1/$steps))}
      opacity: random()

#project-content

  .banner
    width: 100%
    height: 250px
    position: relative
    border: 30px solid white
    .logo
      position: absolute
      top: 30px
      left: 30px
      width: 200px
      height: 200px
      z-index: 9999
      // background-image: url()

    .info-container
      position: absolute
      top: 30px
      bottom: 30px
      left: 45px
      width: calc(100% - 100px)
      +flexbox
      +flex-direction(column)
      +justify-content(center)
      z-index: 9999
      &::after
        content: ''
        width: 100%
        height: 20px
        display: block
        position: absolute
        bottom: -20px
        background: linear-gradient(transparentize($screen-background,1) 50%, transparentize(darken($screen-background,10),0.75) 50%), linear-gradient(90deg,transparentize(#ff0000,0.94),transparentize(#00ff00,0.98),transparentize(#0000ff,0.94))
        z-index: 2
        background-size: 100% 3px, 2px 100%
        pointer-events: none

      .title
        +headerType(normal)
        color: $ink_black
        margin-bottom: 10px
      .client
        text-transform: inherit
        font-size: 15px
        letter-spacing: 1px
        span
          color: $window_border

    .date
      color: $ink_black
      position: absolute
      top: 95px
      right: -75px
      +rotate(90deg)

    .image-mega-container
      width: 250px
      height: 150px
      position: absolute
      top: 20px
      right: 60px
      +flexbox
      +flex-direction(column)
      +align-content(center)
      .image-container
        overflow: hidden
        height: 100%
        width: 100%
        &::after
          top: 0
          margin-left: -15px
          position: absolute
          content: ''
          height: 150px
          width: 150px
          display: block
          border: 1px solid $window_border
          border-radius: 100%
        img
          opacity: .4
          width: 100%
          height: auto

  .content
    padding: 30px 30px 0 30px
    height: calc(100% - 150px)
    width: 100%


</style>
