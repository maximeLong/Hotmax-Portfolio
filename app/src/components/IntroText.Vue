<template>
  <div id="intro-text">
    <typed class="line intro"
      :str="'> Begin startup experience...'"
      :cleanCursor="false"
      :delay="500"
      :cursorChar="'_'"
      :typeSpeed="50"
      v-on:done="lineDone += 1">
    </typed>
    <!-- <typed class="line header"
      :str="'Hotmax'"
      :cleanCursor="true"
      :delay="1000"
      :cursorChar="'_'"
      :typeSpeed="100"
      v-on:done="lineDone += 1"
      v-if="lineDone > 0">
    </typed> -->

    <transition name="fadeup">
      <div id="services-panel" v-if="lineDone == 1">
        <div class="service">{{service}}</div>
      </div>
    </transition>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'introText'
  components:
    Typed: require './Typed'

  data: ->
    lineDone: 0
    currentServicePosition: 0
    currentService: 'Strategy'
    services: ['Strategy', 'Design', 'Sound', 'VR', 'AR']

  mounted: ->
    @$watch 'lineDone', (val)=>
      if val is 1
        setInterval ()=>
          if @currentServicePosition == @services.length - 1
            @currentServicePosition = 0
          else
            @currentServicePosition += 1
        , 4000

  computed:
    service: -> return @services[@currentServicePosition]

</script>

<style lang="sass">
@import src/styles/main

#intro-text
  height: 100%
  width: 100%
  +flexbox
  +flex-direction(column)
  +align-items(flex-start)
  // +justify-content(center)
  .line
    margin: 10px 0
    display: block
    &.intro
      +consoleType(normal)
    &.header
      +headerType(big)
      font-size: 70px
      line-height: 70px

  #services-panel
    margin: 10px 0
    border: 4px solid white
    padding: 20px 0
    width: 100%
    background-color: white
    .service
      +headerType(big)
      color: $console_black
      font-size: 70px
      line-height: 80px
      text-align: center




</style>
