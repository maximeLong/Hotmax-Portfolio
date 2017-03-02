<template>
  <div id="portfolio-text">

    <typed class="line intro"
      :str="'> CD [portfolio]'"
      :cleanCursor="true"
      :delay="500"
      :cursorChar="'_'"
      :typeSpeed="50"
      v-on:done="lineDone += 1">
    </typed>
    <typed class="line intro"
      :str="'> OPEN portfolio README...'"
      :cleanCursor="false"
      :delay="500"
      :cursorChar="'_'"
      :typeSpeed="50"
      v-if="lineDone > 0"
      v-on:done="showContent = true">
    </typed>

    <transition name="fadeup">
      <div class="content" v-if="showContent">
      <div class="main-text">
        A portfolio featuring work done by the two founders individually, work done under the
        hotmax brand, and projects that are currently in development in our labs.
        <br><br>
        Think of it as a showcase for our broad set of skills and interests in interactive media.
      </div>

    </div>
  </transition>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'portfolioText'
  components:
    Typed: require './Typed'

  data: ->
    lineDone: 0
    showContent: false

</script>

<style lang="sass">
@import src/styles/main

#portfolio-text
  .line
    margin: 3px 0
    display: block
    &.intro
      +consoleType(normal)

  .content
    margin-top: 40px
    padding: 20px
    color: white
    border: 1px solid white


</style>
