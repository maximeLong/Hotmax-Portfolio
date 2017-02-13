<template>
  <div id="readme">
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

  .header
    .title
      +consoleHeader
      text-transform: uppercase
      color: $ink_black
      background-color: white
      padding: 10px 20px
      letter-spacing: 1px
    .readme-text
      margin-top: 0
      border: 1px solid white
      padding: 15px 20px


  .readme-group
    margin: 30px 0
    .intro-title
      text-transform: uppercase
      color: $action_color
      font-weight: bold
      font-size: 15px
      letter-spacing: 3px
  .readme-text
    margin: 5px 0
    font-size: 16px
    line-height: 24px
    a
      color: $action_red
      font-weight: bold

    li
      padding: 4px 0
      position: relative
      padding-left: 17px
      span
        font-weight: bold
      &::before
        height: 100%
        position: absolute
        left: 0
        top: 5px
        content: '—'
        color: $action_color
        padding-right: 5px


</style>
