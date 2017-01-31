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
  padding: 20px 0
  margin-top: 20px

  .header
    border-left: 1px solid white
    padding: 10px 20px
    .title
      +showyType
      font-size: 18px
      line-height: 26px
      color: white
      margin-bottom: 10px
    .subheader
      font-size: 14px
      line-height: 23px

  .readme-group
    margin: 30px 0
    padding: 10px 20px
    border-left: 1px solid white
    .title
      +showyType
      font-size: 13px
      color: white
      margin-bottom: 10px
    .list
      div
        font-size: 15px
        margin-bottom: 8px
        &:nth-last-of-type(1)
          margin-bottom: 0
        &::before
          content: '—'
          color: $action_red
          padding-right: 10px


</style>
