<template>
  <div id="our-services">

    <div class="header-container">
      <typed class="title"
        :str="'The Stuff we do'"
        :delay="2000"
        :speed="200"
        :cursorChar="'_'"
        :cleanCursor="false"
        v-on:done="showContent = true">
      </typed>
    </div>
    <transition name="fadeup">
      <div class="content" v-if="showContent">

      this is the kind of stuff we do

    </div>
  </transition>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourServices'
  components:
    Typed: require './Typed'

  mounted: ->
    @$emit('done')

  data: ->
    showContent: false

</script>

<style lang="sass">
@import src/styles/main

#our-services

</style>
