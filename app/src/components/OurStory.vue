<template>
  <div id="our-story">

    <div class="header-container">

      <div class="title-container">
        <div class="title">About Hotmax</div>
        <div class="link-container">
          <div class="link">Our Services</div>
          <div class="link">Contact Us</div>
        </div>
      </div>

      <div class="introduction-container">
        <div class="before-bar"></div>
        <div class="introduction">
          Hotmax is comprised of builders and designers in interactive media, who came together at the start of 2017 to create a lab where our ideas could be developed and published.
          <br>
          Collectively, we've built applications ranging from <span @click="openProjectWindow(projectWindows.curriculum)">interactive textbooks</span> to <span @click="openProjectWindow(projectWindows.arSynth)">augmented reality synthesizers</span>.
        </div>
      </div>

    </div>


    <div class="service-panel">
      <div class="panel-text">
        <div class="title">What sets us apart</div>
        <div class="text">
          We have a philosophy of exploration, connecting aspects of different interactive media
          in novel ways. We’re currently exploring two ideas in greater detail:
          <ul>
            <li>The benefits that AR and VR can provide in existing industry software.</li>
            <li>How giving users meaningful choices and engaging them in intelligent ways, as formalized in video game design, can enhance user retention in other interactive medias.</li>
          </ul>
        </div>
      </div>
    </div>

    <div class="service-panel centered the-team">
      <div class="panel-text">
        <div class="title">The team</div>
        <div class="text">
          Hotmax was founded in 2017 by Andy Katsikapes and Maxime Long.
          <br>
          We have a revolving core of collaborators in design and development, depending on the project.
        </div>
      </div>
      <div class="split-panels">
        <div class="panel">
          <div class="image" id="andy"></div>
          <div class="sub-title">Andy Katsikapes</div>
          <div class="text">
            <div>Andy studied music at the Cornish College of the Arts and speaks fluent Japanese.  He has been designing sound for the better half of his life. When asked what his goal is for life he said, ”I want to make a mixed reality synthesizer that brings the musician into the machine”.</div>
            <div>Hopefully someday we will actually know what that means.</div>
          </div>
        </div>
        <div class="panel">
          <div class="image" id="max"></div>
          <div class="sub-title">Maxime Long</div>
          <div class="text">
            <div>Studied Cognitive Neuroscience at Brown University, and graduated in 2014.</div>
            <div>Max uses his background in cognitive sciences to tackle design problems in a systematic and clear-minded way.</div>
            <div>Max's goal is to build interactive experiences that help people live more beautiful lives.</div>
          </div>
        </div>
      </div>
    </div>

    <div class="service-panel centered contact">
      <div class="panel-text">
        <div class="title">Contact Us</div>
        <div class="text">
          Want to meet us and see how we can help your organization?
          <div class="contact-link">Drop us a line</div>
        </div>
      </div>
    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourStory'
  components:
    Typed: require './Typed'

  methods:
    openProjectWindow: (view)->
      @$store.dispatch 'openProjectWindow', view

  computed:
    projectWindows: ->    return @$store.state.projectWindows


</script>

<style lang="sass">
@import src/styles/main

#our-story
  .service-panel.the-team
    .text
      +screen(mobile)
        text-align: left
    .split-panels
      width: 100%
      +flexbox
      +flex-direction(row)
      +screen(mobile)
        +flex-direction(column)
      .panel
        padding: 20px
        +flex(1 1 50%)
        +screen(mobile)
          padding: 20px 0

        .image
          width: 100%
          height: 20vw
          min-height: 200px
          border: 1px solid $ink_black
          background-position: 50% 25%
          background-size: 100% auto
          background-repeat: no-repeat
          &#andy
            background-image: url('../assets/portraits/andy2.jpg')
          &#max
            background-image: url('../assets/portraits/max2.jpg')



        .sub-title
          margin: 15px 0 5px 0
          +headerType(normal)
          font-size: 25px
          color: $ink_black
        .text
          div
            margin-top: 10px




</style>
