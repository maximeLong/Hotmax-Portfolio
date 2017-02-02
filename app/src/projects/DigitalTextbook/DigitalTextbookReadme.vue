<template>
  <readme>

    <div class="header">
      <div class="title">
        Some catchy way of describing this project in like a sentence or something..
      </div>
      <div class="subheader">
        Fleshing out in a couple more sentences, just the minimal amount of stuff here.. can go into more detail later if needed.
      </div>
    </div>

    <div class="readme-group">
      <div class="title">Our Role</div>
      <div class="list">
        <div>something</div>
        <div>another thing</div>
        <div>something else</div>
        <div>yeeeaah</div>
        <div>garbly gooky book</div>
      </div>
    </div>

    <div class="readme-group">
      <div class="title">Credits</div>
      <div class="list">
        <div>Client: Choices Project at Brown University</div>
        <div>Collaborators: Brown University Web Services</div>
        <div>Working as: Maxime Long</div>
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
