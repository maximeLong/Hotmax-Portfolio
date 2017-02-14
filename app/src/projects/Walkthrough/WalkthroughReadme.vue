<template>
  <readme>

    <div class="header">
      <div class="title">
        Navigating a stage model using map navigation and teleportation
      </div>
      <div class="readme-text">
        Something about Brock - stage designer - asking to help build a walkthrough of his model.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">The Process</div>
      <div class="readme-text">
        <ul>
          <li>Developed in Unity game-engine</li>
          <li>Developed custom VR movement system - using map navigation</li>
          <li>Used Gear VR SDK</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Client</span>: <a href="http://www.kiteandnail.com/" target="_blank">Brock Walker, Kite and Nail, Inc.</a></li>
        </ul>
      </div>
    </div>

  </readme>
</template>

<script lang="coffee">
module.exports =
  name: 'walkthroughReadme'
  components:
    Readme: require '../../components/Readme'

</script>
