<template>
  <div id="our-services">

    <div class="header-container">
      <typed class="title"
        :str="'Our Services'"
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
          Hotmax offers a broad range of services to clients interested in bringing their interactive ideas to life.
          We utilize our skills in web-based application development,
          exploratory technologies like AR and VR, and our background in user-interface and sound design
          to bring complex projects to life.
        </div>
        <div class="intro-title">web and application development</div>
        <div class="main-text">
          <ul>
            <li>Full Design services - from initial concepts and aesthetics, to UI and UX</li>
            <li>Frontend development cycle using Vue, React, or Angular</li>
            <li>Frontend state management with Vuex, Flux, or MobX</li>
            <li>User CMS, built with Node or Firebase</li>
            <li>Server stack using Node(Express) to MongoDB</li>
          </ul>
        </div>
        <div class="intro-title">interactive design</div>
        <div class="main-text">
          <ul>
            <li>3D and interactive development using Unity, Unreal, WebGl, or Three.js</li>
            <li>Exploratory web technologies in AR and VR </li>
            <li>AR and VR SDKs like - Vuphoria, Google Cardboard, Gear VR</li>
            <li>Sound design and musical scoring</li>
            <li>3D interface design</li>
            <li>Interactive storytelling design</li>
          </ul>
        </div>
        <div class="intro-title">Contact Us</div>
        <div class="main-text">
          If these skills fit the needs of your project, <span @click="openOverflowConsole(consoleTexts.contactUs)">drop us a line</span> - we would love to talk.
        </div>

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

  methods:
    openOverflowConsole: (view)->
      @$store.dispatch 'openOverflowConsole', view

  computed:
    consoleTexts: ->      return @$store.state.consoleTexts

</script>

<style lang="sass">
@import src/styles/main

#our-services

</style>
