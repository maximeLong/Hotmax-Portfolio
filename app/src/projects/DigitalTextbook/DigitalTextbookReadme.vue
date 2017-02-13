<template>
  <readme>

    <div class="header">
      <div class="title">
        Creating an interactive textbook experience for students and teachers.
      </div>
      <div class="readme-text">
        Fleshing out in a couple more sentences, just the minimal amount of stuff here.. can go into more detail later if needed.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">Our Role</div>
      <div class="readme-text">
        <ul>
          <li>Designed New Textbook Aesthetic</li>
          <li>Design and development of interactive features for students and teachers in an online textbook</li>
          <li>UI and UX design</li>
          <li>Frontend Development using Angular.js -> Firebase DB</li>
          <li>Wrote custom Javascript CMS for teachers to assign homework, reading, and leave notes to students in the margins</li>
          <li>User Authentication for 1000+ users, and multiple user roles</li>
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
  name: 'digitalTextbookReadme'
  components:
    Readme: require '../../components/Readme'

</script>
