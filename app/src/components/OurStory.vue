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
          Collectively, we've built applications ranging from <span @click="openProjectWindow(projectWindows.curriculum)">interactive textbooks</span> to <span @click="openProjectWindow(projectWindows.arSynth)">augmented reality synthesizers</span>.
          <br>
          Using our broad skillset in web and game development as well as user-interface and
          sound design, we work with clients to bring their complex interactive ideas to life.
        </div>
      </div>

    </div>


    <div class="service-panel">
      <div class="icon"></div>
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

    <div class="service-panel">
      <div class="icon"></div>
      <div class="panel-text">
        <div class="title">The team</div>
        <div class="text">
          We make dope shit. You should hire us fools.
        </div>
      </div>
    </div>

    <!-- <img src="../assets/portraits/max2.jpg">
    <div class="main-text">
      <div>Studied Cognitive Neuroscience at Brown University, and graduated in 2014.</div>
      <div>Max uses his background in cognitive sciences to tackle design problems in a systematic and clear-minded way.</div>
      <div>Max's goal is to build interactive experiences that help people live more beautiful lives.</div>
      <div><a href="https://www.linkedin.com/in/maxime-long-7a886833/">LinkedIn</a></div>
    </div>

    <img src="../assets/portraits/andy2.jpg">
    <div class="main-text">
      <div>Andy studied music at the Cornish College of the Arts and speaks fluent Japanese.  He has been designing sound for the better half of his life. When asked what his goal is for life he said, ”I want to make a mixed reality synthesizer that brings the musician into the machine”.</div>
      <div>Hopefully someday we will actually know what that means.</div>
    </div> -->


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



</style>
