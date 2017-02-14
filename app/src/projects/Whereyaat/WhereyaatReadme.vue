<template>
  <readme>

    <div class="header">
      <div class="title">
        Building a new way to map the past, present, and future of your community.
      </div>
      <div class="readme-text">
        Whereyaat is a social network for people to engage with their community of geographic proximity.
        <br>
        Built on the social-psychological theory of "channel factors", its design tries to overcome the latent reticence in an individual towards involvement with their community of geographic proximity.
        <br>
        People can engage in any geographic level, from an apartment building - to a whole city.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">The Process</div>
      <div class="readme-text">
        <ul>
          <li>UI and UX design</li>
          <li>Vue.js -> Node(Express) -> Mongo pipeline</li>
          <li>Rx.js streaming of geographic data</li>
          <li>Forward and reverse geocoding using open source tools</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Collaborators</span>: <a href="http://johnnysnelgrove.me/" target="_blank">Johnny Snelgrove</a></li>
          <li><span>Progress</span>: Still ongoing development</li>
        </ul>
      </div>
    </div>

  </readme>
</template>

<script lang="coffee">
module.exports =
  name: 'whereyaatReadme'
  components:
    Readme: require '../../components/Readme'

</script>
