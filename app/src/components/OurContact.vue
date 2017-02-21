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
            <div>You can reach the founders of hotmax anytime by writing to our personal inboxes, or by writing to our general inquiries inbox.</div>
            <div>We'll get back to you the same day.</div>
        </div>
        <div class="intro-title">General Inquiries</div>
        <div class="main-text">
          <ul>
            <li>contact@hotmax.co</li>
          </ul>
        </div>
        <div class="intro-title">Co-founder emails</div>
        <div class="main-text">
          <ul>
            <li>Maxime Long : maxime@hotmax.co</li>
            <li>Andy Katsikapes: andy@hotmax.co</li>
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
