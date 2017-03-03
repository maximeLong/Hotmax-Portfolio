<template>
  <readme>

    <div class="header">
      <div class="title">
        Building a new way to map the past, present, and future of your community.
      </div>
      <div class="readme-text">
        Whereyaat is a social network that encourages people to engage with their communities of geographic proximity.
        <br>
        Built on the social psychological theory of “channel factors,” its design strives to help users overcome latent reticence toward involvement with their surroundings.
        <br>
        People can engage at any geographic level, from just an apartment building to an entire city.
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
          <li><span>Progress</span>: Still in development</li>
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
