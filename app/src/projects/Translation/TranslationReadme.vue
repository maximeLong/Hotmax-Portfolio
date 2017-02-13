<template>
  <readme>

    <div class="header">
      <div class="title">
        Creating a lightweight CMS portfolio with multi-language support.
      </div>
      <div class="readme-text">
        Lizzie Davis, a translator and editor for Coffee House Press, needed a custom solution for her translation portfolio that isn't offered by other CMS systems.
        Because her portfolio will be seen by translation experts - she needed a way for people to easily flip between languages when reading different parts of her site.
        <br>
        The CMS created offers markdown support, and was written using Node Express to handle data between the Vue.js frontend and Mongo db.
        The design called for a very trimmed down, two panel interface - where users could easily see her about section while switching between her other pages, and different languages.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">Project Details</div>
      <div class="readme-text">
        <ul>
          <li>Stack: Vue.js -> Node(Express) -> MongoDB</li>
          <li>Literary interface design</li>
          <li>Custom CMS with markdown support</li>
          <li>Custom Express Authentication</li>
          <li>Seamless transition between language options</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Client</span>: Lizzie Davis, Coffee House Press</li>
          <li><span>Link</span>: <a href="http://herokuapp.lizziedavis.com" target="_blank">See Project</a></li>
        </ul>
      </div>
    </div>

  </readme>
</template>

<script lang="coffee">
module.exports =
  name: 'translationReadme'
  components:
    Readme: require '../../components/Readme'

</script>
