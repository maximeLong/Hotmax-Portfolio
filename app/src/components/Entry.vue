<template>
  <div id="entry">

    <transition name="fade">
      <div id="start-entry" v-if="lineIndex < 2">
        <div class="type-container">
          <typed class="line intro"
            :str="'you find an old terminal...'"
            :type-speed="80"
            :cleanCursor="true"
            :delay="2000"
            v-on:done="lineDone">
          </typed>
        </div>

        <div class="choice-container">
          <transition name="fade">
            <div class="choices" v-if="lineIndex == 1">
              <div class="choice" @click="setEntryIndex(1)">turn it on carefully...</div>
              <div class="choice" @click="setEntryIndex(2)">hack the mainframe...</div>
            </div>
          </transition>
        </div>

      </div>
    </transition>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'entry'
  components:
    Typed: require './Typed'
    Three: require './Three'

  data: ->
    lineIndex: 0

  methods:
    lineDone: ->
      @lineIndex += 1

    setEntryIndex: (index)-> @$store.commit 'SET_ENTRY_INDEX', index

  computed:
    webGlIsWorking: ->  return @$store.state.webGlIsWorking
    entryIndex: ->     return @$store.state.entryIndex



</script>

<style lang="sass">
@import src/styles/main

#entry
  .type-container
    height: 50px
  .choice-container
    height: 100px
    .choices
      .choice
        +clickable
        color: $action_color
        padding: 4px 0
        &::before
          content: 'x'
          padding-right: 20px






</style>
