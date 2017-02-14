<template>
  <div id="our-contact">

    <div class="header-container">
      <typed class="title"
        :str="'Dropping a Line'"
        :delay="2000"
        :speed="200"
        :cursorChar="'_'"
        :cleanCursor="false"
        v-on:done="showContent = true">
      </typed>
    </div>
    <transition name="fadeup">
      <div class="content" v-if="showContent">

        <div class="main-text">
            <div>You can reach either one of the founders of hotmax anytime.</div>
            <div>We'll get back to you the same day.</div>
        </div>
        <div class="intro-title">Co-founder emails</div>
        <div class="main-text">
          <ul>
            <li>Maxime Long : long.maxime@gmail.com</li>
            <li>Andy Katsikapes: andyrogerkats@gmail.com</li>
          </ul>
        </div>
    </div>
  </transition>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourContact'
  components:
    Typed: require './Typed'

  mounted: ->
    @$emit('done')

  data: ->
    showContent: false

</script>

<style lang="sass">
@import src/styles/main

#our-contact


</style>
