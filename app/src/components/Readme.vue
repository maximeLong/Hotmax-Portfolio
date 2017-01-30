<template>
  <div id="readme">
    <div class="overview">
      <div class="title">{{activeProjectWindow.meta.shortTitle}}</div>
      <div class="client">{{activeProjectWindow.meta.client}}</div>
    </div>
    <div class="content">
      <slot></slot>
    </div>
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
  padding: 20px
  margin-top: 20px

  .overview
    border-left: 1px solid white
    border-right: 1px solid white
    padding: 5px 20px
    .title
      +showyType
      font-size: 15px
      color: white
      margin-bottom: 10px
  .content
    margin-top: 30px
    padding: 20px
    border: 1px solid white


</style>
