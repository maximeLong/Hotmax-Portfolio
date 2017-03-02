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
      +consoleType(big)
      text-transform: uppercase
      color: $ink_black
      background-color: white
      padding: 10px 20px
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
      font-size: 13px
      letter-spacing: 3px
  .readme-text
    margin: 5px 0
    a
      color: $vapor_blue
      text-decoration: underline
    li
      padding: 4px 0
      position: relative
      padding-left: 21px
      span
        font-weight: bold
      &::before
        height: 100%
        position: absolute
        left: 0
        top: 4px
        content: '—'
        color: $action_color
        padding-right: 5px


</style>
