<template>
  <div id="our-services">

    <div class="header-container">
      <div class="title">The type of stuff we've been doing</div>
    </div>

    <div class="content">
      holy moly is there something we do

    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourServices'



</script>

<style lang="sass">
@import src/styles/main


#our-services
  .header-container
    padding: 30px 0
    margin-bottom: 10px
    &::after
      content: ''
      display: block
      margin-top: 20px
      width: 100px
      height: 9px
      background-color: $action_color
    .title
      +consoleHeader

  .content
    width: 100%


</style>
