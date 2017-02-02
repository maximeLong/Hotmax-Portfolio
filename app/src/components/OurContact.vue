<template>
  <div id="our-contact">

    <div class="header-container">
      <div class="title">Contact Us</div>
    </div>

    <div class="content">
      contact stuff

    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourContact'



</script>

<style lang="sass">
@import src/styles/main


#our-contact
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
