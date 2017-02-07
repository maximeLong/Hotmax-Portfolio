<template>
  <project-content>

    <project-image v-for="n in 10"
      :banner="'curriculum/cc' + n + '.png'"
      :orientation="'landscape'">
    </project-image>




  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'digitalTextbook'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage: require '../../components/ProjectImage'

</script>
