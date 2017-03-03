<template>
  <readme>

    <div class="header">
      <div class="title">
        Creating an interactive textbook experience for students and teachers.
      </div>
      <div class="readme-text">
        Choices Digital Curriculum aimed to give teachers and students subscribed to the Choices Program at Brown a fully interactive experience.
        <br>
        The Choices group had two objectives with the project: They first wanted to give the students a readable but engaging user experience.
        Secondly, they wanted to give teachers the ability to communicate digitally with their students - by leaving notes and embedding media throughout the textbook reading.
      </div>
    </div>

    <div class="readme-group">
      <div class="intro-title">Maxime Long (Co-Founder)'s Role</div>
      <div class="readme-text">
        <ul>
          <li>Designed digital textbook aesthetic</li>
          <li>Strategised, and built the means of teacher-to-student interaction</li>
          <li>UI and UX design</li>
          <li>Frontend development using Angular.js -> Firebase DB</li>
          <li>Wrote custom Javascript CMS so teachers could save notes/media in readings</li>
          <li>User authentication for 1000+ users and multiple user roles</li>
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
