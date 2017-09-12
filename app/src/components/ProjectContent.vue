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
      <button @click="showMobileText = !showMobileText">{{showMobileText ? 'hide project facts' : 'show project facts'}}</button>
      <component v-bind:is="infoConsoleText.readme" v-if="showMobileText"></component>
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
    VirtualSetsReadme:      require '../projects/VirtualSets/VirtualSetsReadme'

  computed:
    activeProjectWindow: -> return @$store.state.activeProjectWindow
    infoConsoleText:   -> return @$store.state.infoConsoleText
    port: ->                return @$store.state.port

</script>

<style lang="sass">
@import src/styles/main

#project-content
  .banner
    padding: 30px
    background-color: #0b3039
    +screen(mobile)
      padding: 20px 15px
    .info-container
      width: 100%
      +flexbox
      +flex-direction(column)
      +justify-content(center)
      z-index: 9999
      .title
        +headerType(big)
        margin-bottom: 10px
        +screen(mobile)
          +headerType(normal)
          font-size: 30px
          line-height: 35px
      .client
        text-transform: inherit
        letter-spacing: 1px
        color: white
        padding-left: 90px
        font-size: 15px
        width: calc(100% - 90px)
        position: relative
        +screen(mobile)
          padding-left: 30px
          width: calc(100% - 30px)
        &::before
          +screen(mobile)
            width: 15px
          content: ''
          display: block
          top: 50%
          left: 0
          position: absolute
          height: 1px
          width: 70px
          background-color: $action_red
          // +screen(tablet)
          //   left: -50%
          //   width: 30px

  .mobile-text
    button
      width: calc(100% - 60px)
      padding: 20px
      border: 2px solid $action_red
      margin: 20px 30px
      background-color: white
      +systemType
      color: $action_red
      outline: 0
      +clickable
      +screen(mobile)
        width: calc(100% - 30px)
        margin: 20px 15px 5px 15px

  .content
    padding: 30px
    height: 100%
    width: 100%
    +screen(mobile)
      padding: 20px 15px

    .iframeContainer
      position: relative
      width: 100%
      height: 0px
      padding-bottom: 56.25%
      iframe
        position: absolute
        top: 0
        left: 0
        width: 100%
        height: 100%
        overflow: hidden



</style>
