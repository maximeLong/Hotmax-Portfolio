<template>
  <project-content>

    <project-image v-for="n in 3"
      :imageUrl="'translation/tr' + n + '.png'"
      :orientation="'landscape'">
    </project-image>

  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'translation'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage: require '../../components/ProjectImage'


</script>
