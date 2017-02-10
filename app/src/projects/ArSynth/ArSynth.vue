<template>
  <project-content>


    <project-image
      :videoUrl="'synth/arMovie.mp4'"
      :imageUrl="'synth/videoThumb.png'"
      :orientation="'landscape'"
      :type="'video'">
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
