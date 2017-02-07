<template>
  <project-content>

    <project-image v-for="n in 5"
      :banner="'video/cv' + n + '.png'"
      :orientation="'portrait'">
    </project-image>

  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'videoPortal'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage: require '../../components/ProjectImage'


</script>
