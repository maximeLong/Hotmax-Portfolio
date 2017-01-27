<template>
  <div id="readme">
    <div class="title">{{activeProjectWindow.meta.realTitle}}</div>
    <slot></slot>
  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'readme'

  computed:
    activeProjectWindow: -> return @$store.state.activeProjectWindow

</script>

<style lang="sass">
@import src/styles/main

#readme
  border: 1px solid white
  padding: 20px
  margin-top: 20px

  .title
    +systemType
    color: white
    margin-bottom: 20px


</style>
