<template>
  <transition appear name="fadeup">
    <div id="window" v-bind:class="type">

      <div class="window-header">
        <div class="line-group"><div class="line" v-for="n in 4"></div></div>
        <div class="close-btn" :class="{ active: canClose}" @click="closeWindow">
        </div>
        <div class="line-group"><div class="line" v-for="n in 4"></div></div>
      </div>
      <div class="short-title">{{shortTitle}}</div>

      <div class="toggle-container" v-if="toggleContainer">
        <div class="portfolio-toggle">
          <div class="toggle-btn" v-for="option in portfolioOptions"
             @click="changeActiveOption(option)"
             :class="{ active: activePortfolioOption == option }">
             {{option}}
          </div>
        </div>
      </div>

      <div class="window-content" ref="windowContent">
        <slot></slot>
      </div>

    </div>
  </transition>
</template>

<script lang="coffee">
module.exports =
  name: 'window'

  props:
    shortTitle:      type: String
    canClose:        type: Boolean
    toggleContainer: {type: Boolean, default: false}
    type:            type: String

  mounted: ->
    @$watch 'projectWindowIsOpen', (val)->
      if val is true then @$refs.windowContent.scrollTop = 0

  computed:
    portfolioOptions: ->        return @$store.state.portfolioOptions
    activePortfolioOption: ->   return @$store.state.activePortfolioOption
    projectWindowIsOpen: ->     return @$store.state.projectWindowIsOpen

  methods:
    changeActiveOption: (option)->
      @$store.commit 'SET_ACTIVE_PORTFOLIO_OPTION', option

    closeWindow: ->
      if @type is 'overlay'
        @$store.commit 'SET_OVERLAY_IS_OPEN', false
      if @type is 'navigator'
        @$store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', false

      if @type is 'project'
        @$store.dispatch 'openPortfolio'
        @$refs.windowContent.scrollTop = 0
      if @type is 'portfolio'
        @$store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', false
      if @type is 'consoleWindow'
        @$store.commit 'SET_OVERFLOW_CONSOLE_IS_OPEN', false

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
  border: 1px solid $window_border
  box-shadow: 20px 20px 0 rgba(253, 95, 96, 0.28)

  .window-header
    padding: 10px 12px
    border-bottom: 1px solid $window_border
    +flexbox
    +align-items(center)
    +flex-direction(row)

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
      position: relative
    .close-btn.active
      border: 1px solid $action_red
      background-color: none
      +transition(.35s ease all)
      &:hover
        cursor: pointer
        background-color: $action_red
        +transition(.35s ease all)

  .short-title
    padding: 10px 30px
    border-bottom: 1px solid $window_border
    +systemType
    font-weight: normal
    font-size: 11px
    letter-spacing: 1px
    color: #4f4f4f
    text-transform: uppercase
    +screen(mobile)
      display: none

  .toggle-container
    border-bottom: 1px solid $window_border
    +screen(mobile)
      display: none
    .portfolio-toggle
      +flexbox
      +flex-direction(row)
      +align-items(center)
      +justify-content(flex-start)

      .toggle-btn
        flex-grow: 1
        +systemType
        letter-spacing: 1px
        color: #595959
        padding: 8px 11px
        display: inline-block
        text-align: center
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
        color: $ink_black
        cursor: default
        +transition(.20s ease all)


  .window-content
    +flex(1)
    background-color: white
    overflow-x: hidden
    overflow-y: scroll
    width: 100%
    height: 100%
  &.consoleWindow > .window-content
    background-color: $console_black


</style>
