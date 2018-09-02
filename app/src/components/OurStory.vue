<template>
  <div id="our-story">

    <div class="header-container">

      <div class="title-container">
        <div class="title">About Hotmax</div>
        <div class="link-container">
          <div class="link" @click="openOverlay(consoleTexts.ourServices)">Our Services</div>
          <div class="link" @click="openOverlay(consoleTexts.contactUs)">Contact Us</div>
        </div>
      </div>

      <div class="introduction-container">
        <div class="before-bar"></div>
        <div class="introduction">
          Hotmax is comprised of designers in interactive media, software, and the live-event industry.
        </div>
      </div>

    </div>


    <div class="service-panel">
      <div class="panel-text">
        <div class="title">What sets us apart</div>
        <div class="text">
          <div>We have a philosophy of exploration, connecting aspects of different interactive media in novel ways.</div>
          <div>We’re currently exploring two ideas in greater detail:</div>
          <ul>
            <li>The benefits that AR and VR can provide in existing industry software.</li>
            <li>Giving live video creators robust and affordable tools to broadcast in AR (Depthcast).</li>
          </ul>
        </div>
      </div>
    </div>

    <div class="service-panel centered the-team">
      <div class="panel-text">
        <div class="title">The team</div>
        <div class="text">
          Hotmax consists of three core members.
        </div>
      </div>
      <div class="split-panels">
        <div class="panel">
          <div class="image" id="andy"></div>
          <div class="sub-title">Andy Katsikapes</div>
          <div class="text">
            <div>Andy studied music at the Cornish College of the Arts and speaks fluent Japanese.
              He has been designing sound for the better half of his life.
              When asked what his goal in life is he said, "I want to make a mixed reality synthesizer that brings the musician into the machine".</div>
            <div>Hopefully someday we will actually know what that means.</div>
          </div>
        </div>
        <div class="panel">
          <div class="image" id="max"></div>
          <div class="sub-title">Maxime Long</div>
          <div class="text">
            <div>Max studied cognitive neuroscience at Brown University, and graduated in 2014.</div>
            <div>He uses his background in cognitive sciences to tackle design problems in a systematic and clear-minded way.</div>
            <div>Max's goal is to build interactive experiences that help people live more beautiful lives.</div>
          </div>
        </div>
        <div class="panel">
          <div class="image" id="reid"></div>
          <div class="sub-title">Reid Santabarbara</div>
          <div class="text">
            <div>Reid has a long history in theatrical lighting design, receiving his first professional lighting credit when he was 15.</div>
            <div>Reid went on to innovate in the industry, designing his own lighting console, and inventing a method of focusing lights with HDR photography.</div>
            <div>Reid also owns Reid Santabarbara Design, a company which provides services for live events and experiences.</div>
          </div>
        </div>
      </div>
    </div>

    <div class="service-panel centered contact">
      <div class="panel-text">
        <div class="title">Contact Us</div>
        <div class="text">
          Want to meet us and see how we can help your organization?
          <div class="contact-link" @click="openOverlay(consoleTexts.contactUs)">Drop us a line</div>
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

    openOverlay: (view)->
      overlay = view
      overlay.orientation = 'portrait'
      @$store.dispatch 'openServicesOverlay', view

  computed:
    projectWindows: ->    return @$store.state.projectWindows
    consoleTexts: ->  return @$store.state.consoleTexts


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
          border-radius: 100%
          &#andy
            background-image: url('../assets/portraits/andy2.jpg')
          &#max
            background-image: url('../assets/portraits/max2.jpg')
          &#reid
            background-image: url('../assets/portraits/reid.jpg')
            background-size: 120%



        .sub-title
          margin: 15px 0 5px 0
          +headerType(normal)
          font-size: 25px
          color: $ink_black
        .text
          div
            margin-top: 10px




</style>
