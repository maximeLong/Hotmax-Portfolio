<template>
  <div id="our-contact">

    <div class="header-container">

      <div class="title-container">
        <div class="title">Contact Us</div>
        <div class="link-container">
          <div class="link" @click="openOverlay(consoleTexts.aboutUs)">About Us</div>
          <div class="link" @click="openOverlay(consoleTexts.ourServices)">Our Services</div>
        </div>
      </div>

      <div class="introduction-container">
        <div class="before-bar"></div>
        <div class="introduction">
          You can write us anytime.
          <br>
          We'll get back to you the same day.
        </div>
      </div>
    </div>

    <div class="service-panel centered">
      <div class="panel-text">
        <div class="title">General Inquiries</div>
        <div class="text">
          contact@hotmax.co
        </div>
      </div>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourContact'
  components:
    Typed: require './Typed'

  methods:
    openOverlay: (view)->
      overlay = view
      overlay.orientation = 'portrait'
      @$store.dispatch 'openServicesOverlay', view

  computed:
    consoleTexts: ->  return @$store.state.consoleTexts

</script>

<style lang="sass">
@import src/styles/main

#our-contact


</style>
