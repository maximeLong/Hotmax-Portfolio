<template>
  <div id="header-panel">
    <div class="system">
      <div class="logo"><img src="../assets/stick-figure.svg"></div>
      <div class="boulder"><img src="../assets/boulder.svg"></div>
      <div class="title">Sisyphus mining corporation | employee terminal</div>
    </div>
  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'headerPanel'

</script>

<style lang="sass">
@import src/styles/main

#header-panel
  position: relative
  padding: 0 50px
  // border-bottom: 2px solid $ink_black
  width: 100%
  height: 100%
  z-index: 9999
  +flexbox
  +align-items(center)
  +justify-content(space-between)
  +flex-direction(row)
  cursor: default

  .system
    +systemType
    height: 40px
    +flexbox
    +align-items(center)
    +flex-direction(row)
    .logo
      width: 40px
      height: 100%
      margin-right: -5px
    .boulder
      +animation(rotate 8s linear infinite)
      height: 100%
      width: 40px
    .title
      padding-left: 10px
      font-weight: normal



</style>
