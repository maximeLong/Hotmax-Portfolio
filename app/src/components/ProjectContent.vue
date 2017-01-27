<template>
  <div id="project-content">

    <div class="banner">
      <img :src="'../static/banners/' + activeProjectWindow.meta.bannerImg">
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
    img
      position: absolute
      height: 100%
      width: 100%
      background-color: $action_color
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
