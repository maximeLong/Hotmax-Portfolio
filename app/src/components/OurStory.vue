<template>
  <div id="our-story">

    <div class="header-container">
      <typed class="title"
        :str="'About hotmax'"
        :delay="2000"
        :speed="200"
        :cursorChar="'_'"
        :cleanCursor="false"
        v-on:done="showContent = true">
      </typed>
    </div>
    <transition name="fadeup">
      <div class="content" v-if="showContent">

        <div class="intro-title">Who We Are</div>
        <div class="main-text">
          We're two friends, both builders and designers in interactive media, that came together at the start of 2017 to create a lab where our ideas could be developed and published.
          Collectively, we've built applications ranging from <span @click="openProjectWindow(projectWindows.curriculum)">interactive textbooks</span>, to <span @click="openProjectWindow(projectWindows.arSynth)">augmented reality synthesizers</span>.
          <br><br>
          We work with clients, using our broad skillset in web and game development, as well as user-interface and sound design, to bring their complex interactive ideas to life.
        </div>

        <div class="intro-title">What sets us apart</div>
        <div class="main-text">
          We have a philosophy of exploration, connecting aspects of different interactive medias in novel ways. We're currently exploring two ideas in greater detail:
          <ul>
            <li>The benefits AR and VR can provide in existing industry software.</li>
            <li>How giving users meaningful choices and engaging them in intelligent ways, as formalized in video game design, can enhance user retention in other interactive medias.</li>
          </ul>
        </div>
        <div class="intro-title">Contact Us</div>
        <div class="main-text">
          You can read how to contact us <span @click="openOverflowConsole(consoleTexts.contactUs)">here</span>.
        </div>


        <div class="portraits">
          <div class="portrait">

            <div class="header">
              <div class="intro-title">Co-Founder</div>
              <div class="name">Maxime Long</div>
            </div>
            <div class="image-container">
              <img src="../assets/portraits/max2.jpg">
            </div>
            <div class="about">
              <div class="intro-title">Background</div>
              <div class="main-text">
                <div>Studied Cognitive Neuroscience at Brown University, and graduated in 2014.</div>
                <div>Max uses his background in cognitive sciences to tackle design problems in a systematic and clear-minded way.</div>
                <div>Max's goal is to build interactive experiences that help people live more beautiful lives.</div>
                <div><a href="https://www.linkedin.com/in/maxime-long-7a886833/">LinkedIn</a></div>
              </div>
            </div>
          </div>

          <div class="portrait">
            <div class="header">
              <div class="intro-title">Co-Founder</div>
              <div class="name">Andy Katsikapes</div>
            </div>
            <div class="image-container"></div>
            <div class="about">
              <div class="intro-title">Background</div>
              <div class="main-text">
                <div>Andy studied music at the Cornish College of the Arts and speaks fluent Japanese.  He has been designing sound for the better half of his life. When asked what his goal is for life he said, ”I want to make a mixed reality synthesizer that brings the musician into the machine”.</div>
                <div>Hopefully someday we will actually know what that means.</div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </transition>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourStory'
  components:
    Typed: require './Typed'

  mounted: ->
    @$emit('done')

  data: ->
    showContent: false

  methods:
    openOverflowConsole: (view)->
      @$store.dispatch 'openOverflowConsole', view
    openProjectWindow: (view)->
      @$store.dispatch 'openProjectWindow', view

  computed:
    consoleTexts: ->      return @$store.state.consoleTexts
    projectWindows: ->    return @$store.state.projectWindows



</script>

<style lang="sass">
@import src/styles/main

#our-story

  padding-bottom: 50px

  .intro
    font-size: 15px
    line-height: 20px
    margin-bottom: 5px

  .portraits
    width: 100%
    margin-top: 40px
    +flexbox
    +align-content(row)
    +justify-content(space-between)
    .portrait
      vertical-align: top
      display: inline-block
      position: relative
      width: 50%
      border: 1px solid white
      padding: 30px
      position: relative
      z-index: 99
      &::before
        content: ''
        display: block
        position: absolute
        top: 20px
        bottom: 20px
        left: -5px
        width: calc(100% + 10px)
        background-color: $console_black
      &::after
        content: ''
        display: block
        position: absolute
        left: 20px
        right: 20px
        top: -5px
        height: calc(100% + 10px)
        background-color: $console_black


      .header
        margin-bottom: 30px
        position: relative
        z-index: 9
        .name
          +consoleHeader
          text-transform: uppercase
          margin-top: 5px
          color: white
          font-size: 30px

      .image-container
        position: relative
        z-index: 9
        width: 100%
        height: 17vw
        border: 1px solid white
        overflow: hidden
        img
          width: 100%
          height: auto

      .about
        position: relative
        z-index: 9
        margin-top: 30px
        .main-text
          font-size: 14px
          line-height: 22px
        div
          margin-bottom: 10px
          &:nth-last-of-type(1)
            margin-top: 15px
        a
          color: $vapor_blue
          text-decoration: underline


</style>
