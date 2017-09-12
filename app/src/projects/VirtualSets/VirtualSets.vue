<template>
  <project-content>

    <div class="iframeContainer">
      <iframe src="https://streamable.com/s/fe85c/vzncob"
        frameborder="0"
        width="100%" height="100%"
        allowfullscreen>
      </iframe>
    </div>

  </project-content>
</template>

<script lang="coffee">
module.exports =
  name: 'virtualSets'
  components:
    ProjectContent: require '../../components/ProjectContent'
    ProjectImage: require '../../components/ProjectImage'
</script>
