<template>
  <project-content>

    <project-image v-for="n in 4"
      :banner="'whereyaat/wy' + n + '.png'"
      :orientation="'landscape'">
    </project-image>

  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'whereyaat'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage: require '../../components/ProjectImage'


</script>
