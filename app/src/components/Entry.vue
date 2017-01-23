<template>
  <div id="entry">

    <transition name="fade">
      <div id="start-entry" v-if="entryIndex < 2">
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
            <div class="choices" v-if="entryIndex == 1">
              <div class="choice" @click="lineDone">turn it on...</div>
              <div class="choice">leave it alone...</div>
            </div>
          </transition>
        </div>
      </div>
    </transition>

    <transition name="glitch">
      <div id="login-entry" v-if="entryIndex > 1">
        <three v-if="webGlIsWorking"></three>
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
    entryIndex: 0

  methods:
    lineDone: ->
      @entryIndex += 1
      console.log @entryIndex

  computed:
    webGlIsWorking: -> return @$store.state.webGlIsWorking



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
