<template>
  <div id="popup-panel">

    <div class="popup file">
      <div class="list">
        <div class="item" v-for="project in projectWindows">{{project.meta.shortTitle}}</div>
      </div>
    </div>

    <div class="popup help">
      <button @click="openOverlay(consoleTexts.ourServices)">hotmax services</button>
    </div>


  </div>
</template>

<script lang="coffee">

module.exports =
  name: 'popupPanel'

  methods:
    # openPortfolio: ()->
    #   @$store.dispatch 'openPortfolio'

    openOverlay: (view)->
      overlay = view
      overlay.orientation = 'portrait'
      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', view

  computed:
    #vuex state
    consoleTexts: ->          return @$store.state.consoleTexts
    projectWindows: ->        return @$store.state.projectWindows




</script>

<style lang="sass">
@import src/styles/main

#popup-panel
  width: 100%
  +transition(.35s ease all)
  z-index: 995
  position: absolute
  bottom: 30px

  .popup
    padding: 10px
    width: 320px
    background-color: black
    +flexbox
    +align-content(column)

    .list
      width: 100%
      border: 1px solid white
      padding: 20px
      +systemType
      .item
        display: inline-block
        background-color: white
        border-bottom: 1px solid white
        margin: 5px 0
        padding: 5px



    &.file
      +translateXY(30px, 0)
    &.help
      display: none

</style>
