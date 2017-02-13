<template>
  <readme>

    <div class="header">
      <div class="title">
        A video publishing app for Ivy League Academics
      </div>
      <div class="readme-text">
        something about the video portal -- choices sponsored academics published their videos about certain subjects.
        designed user interface and experience, and developed frontend codebase connecting to drupal api.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">Our Role</div>
      <div class="readme-text">
        <ul>
          <li>Designed Academic Video Portal Aesthetic</li>
          <li>UI and UX design</li>
          <li>Frontend Development using Angular.js -> connected to Drupal API</li>
          <li>Designed and Developed responsive interface</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Client</span>: Choices Program @ Brown University</li>
          <li><span>Collaborators</span>: Brown Web Services</li>
          <li><span>Working as</span>: Maxime Long</li>
        </ul>
      </div>
    </div>

  </readme>
</template>

<script lang="coffee">
module.exports =
  name: 'videoPortalReadme'
  components:
    Readme: require '../../components/Readme'

</script>
