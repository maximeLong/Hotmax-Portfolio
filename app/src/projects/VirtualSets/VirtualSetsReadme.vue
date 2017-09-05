<template>
  <readme>

    <div class="header">
      <div class="title">
        Realtime and interactable CG for broadcast sets
      </div>
      <div class="readme-text">
        Using depth-based camera technology and VR tracking, we take live feeds of announcers in a greenscreen stage and transpose them into a virtual environment
        where they are fully illuminated and surrounded with virtual lights and objects.
        <br>
        We are currently testing this idea to take place of traditional announcer broadcasting for certain events that benefit from
        CG magic happening around the announcer in realtime.
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Hotmax's Role</div>
      <div class="readme-text">
        <ul>
          <li>Integrate broadcast stage designs with interactive and virtual features</li>
          <li>Run realtime mixing of greenscreen video and virtual environment using Unity engine</li>
          <li>Director features like DMX lighting in Unity, and multi-camera broadcast support</li>
        </ul>
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Credits</div>
      <div class="readme-text">
        <ul>
          <li><span>Collaborators</span>: Reid Santabarbara Design</li>
        </ul>
      </div>
    </div>

  </readme>
</template>

<script lang="coffee">
module.exports =
  name: 'virtualSetsReadme'
  components:
    Readme: require '../../components/Readme'

</script>
