<template>
  <project-content>

    <project-image
      :videoUrl="'synth/arMovie2.mp4'"
      :imageUrl="'synth/ar4.png'"
      :orientation="'landscape'"
      :type="'video'">
    </project-image>

    <project-image
      :videoUrl="'synth/arMovie.mp4'"
      :imageUrl="'synth/ar1.jpg'"
      :orientation="'landscape'"
      :type="'video'">
    </project-image>

    <project-image
      :imageUrl="'synth/ar2.jpg'"
      :orientation="'landscape'">
    </project-image>


  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'arSynth'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage:   require '../../components/ProjectImage'

</script>

<style lang="sass">


</style>
