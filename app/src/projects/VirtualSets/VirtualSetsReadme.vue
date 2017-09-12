<template>
  <readme>

    <div class="header">
      <div class="title">
        Live Interactive CGI
      </div>
      <div class="readme-text">
        Using depth-based camera technology and VR tracking, we take live feeds of actors and transpose them into a virtual environment, all in real time.
        Actors are fully illuminated with virtual light and shadow, and surrounded with virtual objects they can interact with.
      </div>
    </div>
    <div class="readme-group">
      <div class="intro-title">Roadmap for 2017</div>
      <div class="readme-text">
        Hotmax is currently exploring this tool in the following areas:
        <ul>
          <li>E-Sports Studio Broadcasting that would benefit from FX normally only found in post-production and VR, being used used in realtime, around announcers and players.</li>
          <li>Previz software for lighting and stage designers.
              Designers can cheaply and quickly place, test, and view virtual lighting conditions on real people.
              Designers can also connect DMX channels to virtual light attributes.</li>
          <li>Twitch live-streaming. Streamers can easily drag in their own virtual environments and lighting conditions for a true MR experience.</li>
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
