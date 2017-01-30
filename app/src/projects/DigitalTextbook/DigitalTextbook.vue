<template>
  <project-content>

    <project-image
      :banner="'video/home.png'"
      :orientation="'portrait'">
      image caption stuff
    </project-image>

    <project-image
      :banner="'video/scholar_page.png'"
      :orientation="'portrait'">
      some other caption
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
