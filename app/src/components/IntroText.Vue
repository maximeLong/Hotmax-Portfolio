<template>
  <div id="intro-text">

    <typed class="line"
      :str="'Make'"
      :cleanCursor="true"
      :delay="initialDelay"
      :cursorChar="'_'"
      :typeSpeed="100"
      v-on:done="lineDone">
    </typed>
    <typed class="line"
      :str="'Dope'"
      :cleanCursor="true"
      :delay="500"
      :cursorChar="'_'"
      :typeSpeed="100"
      v-on:done="lineDone"
      v-if="sentenceIndex > 0">
    </typed>
    <typed class="line"
      :str="'Apps.'"
      :cleanCursor="false"
      :cursorChar="'_'"
      :delay="500"
      :typeSpeed="100"
      v-on:done="emitDone"
      v-if="sentenceIndex > 1">
    </typed>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'introText'
  components:
    Typed: require './Typed'

  data: ->
    sentenceIndex: 0
    windowCount: 0

  methods:
    lineDone: ->
      @sentenceIndex += 1
    emitDone: ->
      @$emit('done')

  computed:
    taskNumber: -> return Math.floor((Math.random() * 10000) + 1)

</script>

<style lang="sass">
@import src/styles/main

#intro-text
  margin-bottom: 20px
  .line
    +showyType
    color: white
    display: block
    letter-spacing: 3px
    margin: 10px 0

</style>
