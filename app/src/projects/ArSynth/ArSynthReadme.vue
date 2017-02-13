<template>
  <readme>

    <div class="header">
      <div class="title">
        Any dollar bill can be turned into a synthesizer
      </div>
      <div class="readme-text">
        An iOS app that uses AR tech to put a mini synthesizer keyboard under your fingertips.
        It has seven sounds, three effect sliders for warping the sound, and one octave of keys.
        AR $ynth is a completely new way to play music.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">The Process</div>
      <div class="readme-text">
        <ul>
          <li>Sound Design</li>
          <li>Unity development</li>
          <li>UI design</li>
          <li>Vuphoria AR SDK integration</li>
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
