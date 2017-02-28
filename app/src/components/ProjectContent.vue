<template>
  <div id="project-content">

    <div class="banner">
      <transition appear name="fadeup">
        <div class="info-container">
          <div class="title">{{activeProjectWindow.meta.realTitle}}</div>
          <div class="client">{{activeProjectWindow.meta.client}}</div>
        </div>
      </transition>
    </div>

    <div class="mobile-text" v-if="port != 'desktop'">
      <button @click="showMobileText = !showMobileText">showMobileText</button>
      <component v-bind:is="normalConsoleText.readme" v-if="showMobileText"></component>
    </div>

    <div class="content">
      <slot></slot>
    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'projectContent'

  data: ->
    showMobileText: false

  components:
    DigitalTextbookReadme:  require '../projects/DigitalTextbook/DigitalTextbookReadme'
    VideoPortalReadme:      require '../projects/VideoPortal/VideoPortalReadme'
    WhereyaatReadme:        require '../projects/Whereyaat/WhereyaatReadme'
    ArSynthReadme:          require '../projects/ArSynth/ArSynthReadme'
    TranslationReadme:      require '../projects/Translation/TranslationReadme'
    WalkthroughReadme:      require '../projects/Walkthrough/WalkthroughReadme'

  computed:
    activeProjectWindow: -> return @$store.state.activeProjectWindow
    normalConsoleText:   -> return @$store.state.normalConsoleText
    port: ->                return @$store.state.port

</script>

<style lang="sass">
@import src/styles/main

@keyframes flicker
  $steps: 20
  @for $i from 0 through $steps
    #{percentage($i*(1/$steps))}
      opacity: random()

#project-content
  padding: 30px
  +screen(mobile)
    padding: 20px 15px

  .banner
    margin-bottom: 40px

    .info-container
      width: 100%
      +flexbox
      +flex-direction(column)
      +justify-content(center)
      z-index: 9999

      .title
        +headerType(big)
        color: $ink_black
        margin-bottom: 10px
        +screen(mobile)
          +headerType(normal)
          font-size: 30px
          line-height: 35px
          color: $ink_black

      .client
        text-transform: inherit
        font-size: 15px
        letter-spacing: 1px

  .content
    height: calc(100% - 150px)
    width: 100%


</style>
