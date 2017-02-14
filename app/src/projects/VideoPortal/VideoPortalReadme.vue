<template>
  <readme>

    <div class="header">
      <div class="title">
        A video publishing app for Ivy League Academics
      </div>
      <div class="readme-text">
        The Choices Program at Brown needed a repository for their published videos, and a landing page that acted as a showcasing of different material.
        <br>
        The application needed a fully featured CMS, but also a fast and responsive frontend experience.
        <br>
        Maxime Long, working alongside Brown Web Services built an Angular.js frontend connected to a Drupal CMS api to achieve these requirements.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">Maxime Long (Co-Founder)'s Role</div>
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
