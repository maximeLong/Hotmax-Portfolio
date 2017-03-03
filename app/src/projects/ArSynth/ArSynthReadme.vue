<template>
  <readme>

    <div class="header">
      <div class="title">
        Any dollar bill can be turned into a synthesizer
      </div>
      <div class="readme-text">
        An iOS app that uses AR tech to put a mini synthesizer keyboard under your fingertips.
        It has seven sounds, three effect sliders for warping notes, and one octave of keys.
        AR Synth is a completely new way to play music.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">Project Details</div>
      <div class="readme-text">
        <ul>
          <li>Sound design used multiple MIDI distortion effects</li>
          <li>Developed using Unity game-engine</li>
          <li>Built with Vuphoria AR integration</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Published</span>: Hotmax Published</li>
          <li><span>Link</span>: <a href="https://itunes.apple.com/us/app/ar-$ynth/id1179663804?mt=8" target="_blank">App Store</a></li>
        </ul>
      </div>
    </div>

  </readme>
</template>

<script lang="coffee">
module.exports =
  name: 'arSynthReadme'
  components:
    Readme: require '../../components/Readme'

</script>
