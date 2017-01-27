<template>
  <!-- TODO: afternoon Indians should be wavy and rainbow -->
  <span class="type-container">
    <transition-group name="fade">
      <span class="typed" v-for="type in typed" v-bind:key="type" :class="type.typeClass">{{ type.letter }}</span>
    </transition-group>
    <span class="cursor" v-if="shouldShowCursor">{{ cursorChar }}</span>
  </span>
</template>

<script lang="coffee">
module.exports =
  name: 'typed'

  props:
    str:
      type: String
      required: true
    typeSpeed:
      type: Number
      default: 50
    delay:
      type: Number
      default: 700
    cursorChar:
      type: String
      default: '|'
    cleanCursor:
      type: Boolean
      default: false

  data: ->
    typed: []
    strIndex: 0
    sentenceIndex: 0
    shouldShowCursor: true
    bracket: false
    logo: false

  mounted: ->
    # make typeSpeed not less than 16
    @typeSpeed = Math.max(@typeSpeed, 16)
    setTimeout =>
      @type()
    , @delay

    @$watch 'cleanCursor', (newVal, oldVal)=>
      if newVal == true
        @shouldShowCursor = false
      if newVal == false
        @shouldShowCursor = true

  methods:
    type: ()->
      if @strIndex is @str.length # type finish!
        if @cleanCursor then @shouldShowCursor = false
        @$emit('done')
      else
        setTimeout =>
          if @str[@strIndex - 1] is '[' then @bracket = true
          if @str[@strIndex] is ']' then @bracket = false

          if @str[@strIndex] is 'A' and @str[@strIndex + 1] is 'f' and @str[@strIndex + 2] is 't' then @logo = true
          if @str[@strIndex] is ' ' and @str[@strIndex - 1] is 's' and @str[@strIndex - 2] is 'n' then @logo = false

          if !@bracket and !@logo then typeClass = 'normal'
          if @bracket then typeClass = 'bracket'
          if @logo then typeClass = 'logo'
          @typed.push
            letter: @str[@strIndex]
            typeClass: typeClass
          @strIndex += 1
          @type()
        , @typeSpeed


</script>

<style lang="sass">
@import src/styles/main

.type-container
  .typed
    padding: 0 1px 0 0
    &.bracket
      color: $action_color
    &.logo
      color: $action_red
      animation: bobble 1s infinite ease-in
      display: inline-block

  .cursor
    opacity: 1
    font-weight: 100
    animation: blink 1.3s infinite

@keyframes blink
  0%
    opacity: 1
  50%
    opacity: 0
  100%
    opacity: 1

@keyframes bobble
  0%
    +translate3d(0,0,0)
  25%
    +translate3d(0,-5px,0)
  50%
    +translate3d(0,0,0)
  75%
    +translate3d(0,5px,0)
  100%
    +translate3d(0,0,0)



</style>
