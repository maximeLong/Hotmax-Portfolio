<template>
  <div id="rubbish-bin">

    <div class="content icon-grid">
      <div @click="openOverlay(overlays.asteroids)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">asteroids.exe</div>
      </div>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'rubbishBin'

  methods:
    openOverlay: (view)->
      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', view
  computed:
    overlays: -> return @$store.state.overlays

</script>

<style lang="sass">
@import src/styles/main


#rubbish-bin
  .icon-grid
    .icon
      &:nth-child(1)
        +translate3d(0px, -20px, 0)

</style>
