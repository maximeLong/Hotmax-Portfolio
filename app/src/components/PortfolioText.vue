<template>
  <div id="portfolio-text">

    <div class="header-container">
      <typed class="title"
        :str="'Our shit'"
        :delay="2000"
        :speed="200"
        :cursorChar="'_'"
        :cleanCursor="false"
        v-on:done="showContent = true">
      </typed>
    </div>
    <transition name="fadeup">
      <div class="content" v-if="showContent">

      check out our shit

    </div>
  </transition>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'portfolioText'
  components:
    Typed: require './Typed'

  data: ->
    showContent: false

</script>

<style lang="sass">
@import src/styles/main

#portfolio-text

</style>
