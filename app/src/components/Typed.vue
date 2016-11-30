<template>
  <span class="typed">{{ typed }}<span class="cursor" v-if="shouldShowCursor">{{ cursorChar }}</span></span>
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
    typed: ''
    strIndex: 0
    sentenceIndex: 0
    shouldShowCursor: true

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
      if @strIndex == @str.length
        # type finish!
        if @cleanCursor
          @shouldShowCursor = false
        @$emit('done')
        return
      else
        setTimeout =>
          @typed += @str[@strIndex]
          @strIndex += 1
          @type()
        , @typeSpeed


</script>

<style scoped>

.typed {
  white-space: pre;
}

.cursor {
  opacity: 1;
  font-weight: 100;
  animation: blink 1.3s infinite;
}

@keyframes blink {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}

</style>
