<template>
  <project-content>

    <project-image
      :videoUrl="'virtualSets/virtualSetTrim.mp4'"
      :imageUrl="'virtualSets/vs1.png'"
      :orientation="'landscape'"
      :type="'video'">
    </project-image>

  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'virtualSets'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage: require '../../components/ProjectImage'
</script>
