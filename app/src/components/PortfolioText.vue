<template>
  <div id="portfolio-text">

    <div class="header-container">
      <typed class="title"
        :str="'Collected Work'"
        :delay="500"
        :speed="200"
        :cursorChar="'_'"
        :cleanCursor="false"
        v-on:done="showContent = true">
      </typed>
    </div>
    <transition name="fadeup">
      <div class="content" v-if="showContent">

      <div class="main-text">
        A portfolio featuring work done by the two founders individually, work done under the
        hotmax brand, and projects that are currently in development in our labs.
        <br><br>
        Think of it as a showcase for our broad set of skills and interests in interactive media.
      </div>

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
