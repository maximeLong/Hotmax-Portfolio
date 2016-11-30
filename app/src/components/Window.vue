<template>
  <div id="window">

    <div class="window-header">
      <div class="line-group"><div class="line" v-for="n in 4"></div></div>
      <div class="close-btn" :class="{ active: canClose}" @click="closeWindow">
        <span v-if="canClose">x</span>
      </div>
      <div class="line-group"><div class="line" v-for="n in 4"></div></div>
    </div>

    <div class="short-title">{{shortTitle}}</div>

    <div class="real-title-container" v-if="realTitle">
      <div class="real-title">{{realTitle}}</div>
      <div class="portfolio-toggle">
        <div class="toggle-btn"
             @click="portfolioOption = 'technical'"
             :class="{ active: portfolioOption == 'technical' }">> Technical</div>
        <div class="toggle-btn"
             @click="portfolioOption = 'aesthetic'"
             :class="{ active: portfolioOption == 'aesthetic' }">> Aesthetic</div>
      </div>
    </div>

    <div class="window-content">
      <slot></slot>
    </div>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'window'

  props:
    shortTitle: type: String
    realTitle:  type: String
    canClose:   type: Boolean

  data: ->
    portfolioOption: 'aesthetic'

  methods:
    closeWindow: -> @$store.commit 'SET_WINDOW_IS_OPEN', false


</script>

<style lang="sass">
@import src/styles/main

#window
  +flexbox
  +flex-direction(column)
  background-color: $window_background
  z-index: 99
  height: 100%
  width: 100%
  border: 1px solid #939393
  box-shadow: 20px 20px 0 rgba(95, 166, 217, 0.18)

  .window-header
    padding: 10px 12px
    border-bottom: 1px solid $window_border
    +flexbox
    +align-items(center)
    +flex-direction(row)
    &:hover > .close-btn.active span
      opacity: 1
      +transition(.20s ease all)

    .line-group
      +flexbox
      +flex-direction(column)
      +justify-content(space-between)
      height: 16px
      &:nth-of-type(1)
        width: 15px
      &:nth-last-of-type(1)
        +flex(1)
      .line
        height: 1px
        width: 100%
        background-color: $window_border

    .close-btn
      border: 1px solid $window_border
      height: 16px
      width: 16px
      margin: 0 5px
    .close-btn.active
      border: 1px solid $action_red
      +clickable
      +flexbox
      +justify-content(center)
      +align-items(center)
      span
        color: $action_red
        height: 100%
        opacity: 0
        +transition(.35s ease all)

  .short-title, .real-title-container
    padding: 10px 30px
    border-bottom: 1px solid $window_border
  .short-title
    color: #4f4f4f
    text-transform: uppercase
  .real-title-container
    padding: 15px 30px
    .real-title
      font-size: $font_size_big
      color: #606161
      font-weight: bold
    .portfolio-toggle
      display: block
      margin: 15px 0 5px 0
      .toggle-btn
        padding: 8px 14px
        display: inline-block
        border-top: 1px solid white
        border-left: 1px solid white
        border-right: 1px solid grey
        border-bottom: 1px solid grey
        box-shadow: 1px 1px 0px $window_border
        +clickable
        +transition(.20s ease all)
      .toggle-btn.active
        border-top: 1px solid grey
        border-left: 1px solid grey
        border-right: 1px solid white
        border-bottom: 1px solid white
        box-shadow: inset 1px 1px 0px $window_border
        background-color: #ececec
        cursor: default
        +transition(.20s ease all)



  .window-content
    +flex(1)
    background-color: white
    overflow-x: hidden
    overflow-y: scroll
    width: 100%
    height: 100%



</style>
