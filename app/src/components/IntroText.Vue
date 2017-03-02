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
        <!-- <div class="service">{{service}}</div> -->

        <div class="service-container" v-if="service == 'Strategy'">
          <div class="service">{{service}}</div>
        </div>


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
    services: ['Strategy', 'Design', 'Sound', 'Virtual']

  mounted: ->
    # @$watch 'lineDone', (val)=>
    #   if val is @startServiceId
    #     setInterval ()=>
    #       if @currentServicePosition == @services.length - 1
    #         @currentServicePosition = 0
    #       else
    #         @currentServicePosition += 1
    #     , 4000

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
    border: 4px solid white
    padding: 20px 0
    width: 100%
    background-color: white
    align-self: flex-end
    position: relative
    .service
      +headerType(big)
      color: $console_black
      font-size: 70px
      line-height: 80px
      text-align: center

      -webkit-background-clip: text
      color: transparent

      background-position: 50% 50%
      background-size: 100% auto
      background-repeat: no-repeat
      background-image: url('../assets/flower-bloom.gif')



</style>
