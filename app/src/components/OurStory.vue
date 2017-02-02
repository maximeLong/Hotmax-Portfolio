<template>
  <div id="our-story">

    <div class="header-container">
      <div class="title">Meet the team</div>
    </div>

    <div class="content">
      damn we look good brah

    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourStory'



</script>

<style lang="sass">
@import src/styles/main


#our-story
  .header-container
    padding: 30px 0
    margin-bottom: 10px
    &::after
      content: ''
      display: block
      margin-top: 20px
      width: 100px
      height: 9px
      background-color: white
    .title
      +consoleHeader

  .content
    width: 100%


</style>
