<template>
  <div id="our-story">

    <div class="header-container">
      <typed class="title"
        :str="'The Team'"
        :delay="2000"
        :speed="200"
        :cursorChar="'_'"
        :cleanCursor="false"
        v-on:done="showContent = true">
      </typed>
    </div>
    <transition name="fadeup">
      <div class="content" v-if="showContent">

        <div class="intro">hotmax is a small team of dedicated artists, designers, and thinkers based in Seattle, Washington.</div>
        <div class="intro">Our collective background includes music, design, software development, and psychology.</div>

        <div class="portraits">
          <div class="portrait">

            <div class="header">
              <div class="title">Co-Founder, Designer</div>
              <div class="name">Max Long</div>
            </div>
            <div class="image-container">
              <img src="../assets/portraits/max2.jpg">
            </div>
            <div class="about">
              <div class="title">Background</div>
              <div class="text">
                <div>Studied Cognitive Neuroscience at Brown University, and graduated in 2014.</div>
                <div>Max's goal is just to build tools, interfaces, and aesthetics that make people feel good.</div>
                <div><a href="https://www.linkedin.com/in/maxime-long-7a886833/">LinkedIn</a>, <a href="https://www.instagram.com/neuraldoughnuts/">Instagram</a></div>
              </div>
            </div>
          </div>

          <div class="portrait">
            <div class="header">
              <div class="title">Co-Founder</div>
              <div class="name">Andy Katsikapes</div>
            </div>
            <div class="image-container"></div>
            <div class="about">
              <div class="title">Background</div>
              <div class="text">
                <div>Andy once ate like 20 nachos stuck together.</div>
                <div>Andy likes to eat nachos but he's a good guy too.</div>
                <div><a href="https://www.linkedin.com/in/maxime-long-7a886833/">LinkedIn</a>, <a href="https://www.instagram.com/neuraldoughnuts/">Instagram</a></div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </transition>

  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourStory'
  components:
    Typed: require './Typed'

  mounted: ->
    @$emit('done')

  data: ->
    showContent: false



</script>

<style lang="sass">
@import src/styles/main

#our-story

  padding-bottom: 50px

  .intro
    font-size: 15px
    line-height: 20px
    margin-bottom: 5px

  .portraits
    width: 100%
    margin-top: 40px
    +flexbox
    +align-content(row)
    +justify-content(space-between)
    .portrait
      vertical-align: top
      display: inline-block
      position: relative
      width: 50%
      border: 1px solid white
      padding: 30px
      position: relative
      z-index: 99
      &::before
        content: ''
        display: block
        position: absolute
        top: 20px
        bottom: 20px
        left: -5px
        width: calc(100% + 10px)
        background-color: $console_black
      &::after
        content: ''
        display: block
        position: absolute
        left: 20px
        right: 20px
        top: -5px
        height: calc(100% + 10px)
        background-color: $console_black


      .header
        margin-bottom: 30px
        position: relative
        z-index: 9
        .title
          +defaultType
          font-size: 14px
          color: white
          margin-bottom: 10px
          &::after
            content: '_'
            padding-left: 4px
        .name
          +showyType
          color: white
          font-size: 27px
          letter-spacing: 2px

      .image-container
        position: relative
        z-index: 9
        width: 100%
        height: 250px
        border: 1px solid white
        overflow: hidden
        img
          width: 100%
          height: auto

      .about
        font-size: 16px
        line-height: 23px
        position: relative
        z-index: 9
        margin-top: 30px
        div
          margin-bottom: 5px
          &:nth-last-of-type(1)
            margin-top: 15px
        a
          color: $action_color
          font-style: italic
        .title
          +defaultType
          font-size: 14px
          color: white
          margin-bottom: 10px
          &::after
            content: '_'
            padding-left: 4px


</style>
