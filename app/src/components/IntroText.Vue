<template>
  <div id="intro-text">

    <typed class="line"
      :str="'Welcome [POTENTIAL CANDIDATE] to the hotmax work station.'"
      :cleanCursor="true"
      :delay="1500"
      v-on:done="lineDone">
    </typed>
    <typed class="line"
      :str="'Please read through the company information at your leisure.'"
      :cleanCursor="true"
      :delay="250"
      v-on:done="lineDone"
      v-if="sentenceIndex > 0">
    </typed>
    <typed class="line"
      :str="'Contact a supervisor on completion, you now have [' + taskNumber + '] tasks waiting.'"
      :cleanCursor="true"
      :delay="250"
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
    display: block
    margin: 10px 0
    text-transform: uppercase

</style>
