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
          <li>Sound design uses multiple MIDI distortion effects for playful synthesizer experience</li>
          <li>Developed using Unity</li>
          <li>Built with Vuphoria AR integration</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Published</span>: TBD (early 2018)</li>
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
