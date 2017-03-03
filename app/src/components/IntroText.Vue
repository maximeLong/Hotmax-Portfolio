<template>
  <div id="intro-text">

    <typed class="line intro"
      :str="'> Opening hotmax OS V.1.01'"
      :cleanCursor="true"
      :delay="500"
      :cursorChar="'_'"
      :typeSpeed="50"
      v-on:done="lineDone += 1">
    </typed>
    <typed class="line intro"
      :str="'> Begin profile experience...'"
      :cleanCursor="false"
      :delay="500"
      :cursorChar="'_'"
      :typeSpeed="50"
      v-if="lineDone > 0"
      v-on:done="lineDone += 1">
    </typed>

    <transition name="fadeup">
      <div id="services-panel" v-if="lineDone == startServiceId">
        <div class="intro">Hotmax does</div>

        <transition name="fadeup" mode="out-in">
          <div class="service strategy" v-if="service == 'Interactive Strategy'" key="int">{{service}}</div>
          <div class="service design" v-if="service == 'Digital Design'" key="des">{{service}}</div>
          <div class="service vr" v-if="service == 'Virtual Reality'" key="vr">{{service}}</div>
          <div class="service ar" v-if="service == 'Augmented Reality'" key="ar">{{service}}</div>
        </transition>

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
    startServiceId: 2
    lineDone: 0
    currentServicePosition: 0
    currentService: 'Strategy'
    services: ['Interactive Strategy', 'Digital Design', 'Virtual Reality', 'Augmented Reality']

  mounted: ->
    @$watch 'lineDone', (val)=>
      if val is @startServiceId
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
  .line
    margin: 3px 0
    display: block
    &.intro
      +consoleType(normal)
    &.header
      +headerType(big)
      font-size: 70px
      line-height: 70px

  #services-panel
    margin-top: 30px
    padding: 20px 0
    align-self: flex-start
    position: relative
    border-top: 1px solid white
    +headerType(big)
    font-size: 9vh
    line-height: 10vh
    color: white
    .service
      padding-bottom: 10px
      word-spacing: 9999999px
      -webkit-background-clip: text
      color: transparent
      background-position: 50% 50%
      background-size: 100% auto
      background-repeat: no-repeat
      &.strategy
        background-image: url('../assets/flower-bloom.gif')
      &.design
        background-image: url('../assets/design.gif')
      &.ar
        background-image: url('../assets/waves.gif')
      &.vr
        background-image: url('../assets/blue.gif')



</style>
