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

        <div class="contact-container">
          <div class="header">
            <div>We're not going to waste your time with an online form you'll never use.</div>
            <div>To get a hold of us, just email either one of the founders.</div>
            <div>We'll get back to you the same day.</div>
          </div>
          <div class="info-panel">
            <div class="title">Co-founder emails</div>
            <div class="email">long.maxime@gmail.com</div>
            <div class="email">andyDude@gmail.com</div>
          </div>
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
  font-size: 15px
  line-height: 20px
  .header
    width: 100%
    div
      margin-bottom: 5px
  .info-panel
    margin: 30px 0
    .title
      +defaultType
      font-size: 14px
      color: white
      margin-bottom: 10px
      &::after
        content: '_'
        padding-left: 4px
    .email
      margin-bottom: 20px
      +showyType
      font-size: 22px
      letter-spacing: 2px
      color: white
      margin-bottom: 20px


</style>
