<template>
  <div id="our-story">

    <div class="header-container">
      <div class="title">Just a couple of broskis</div>
    </div>
    <div class="content">

      <div class="portraits">
        <div class="portrait">

          <div class="image-container">
            <img class="dark" src="../assets/portraits/portrait-dark.png">
            <img class="normal" src="../assets/portraits/portrait-real.png">
          </div>

          <div class="svg"></div>

          <!-- <svg width="200" height="300"
            <g class="svg">
              <polygon :points="points"></polygon>
              <circle cx="100" cy="100" r="80"></circle>
              <axis-label
                v-for="(stat, index) in stats"
                :stat="stat"
                :index="index"
                :total="stats.length">
              </axis-label>
            </g>
          </svg> -->

          <div class="about">about text</div>
        </div>

        <div class="portrait">
          <div class="image-container"></div>
          <div class="svg"></div>
          <div class="about">about text</div>
        </div>
      </div>

    </div>


  </div>
</template>

<script lang="coffee">
module.exports =
  name: 'ourStory'

  data: ->
    stats: [
      { value: 100 },
      { value: 100 },
      { value: 100 },
      { value: 100 },
      { value: 100 },
      { value: 100 }
    ]

  computed:
    #a computed property for the polygon's points
    points: ()->
      total = @stats.length
      @stats.map (stat, i)=>
        point = @valueToPoint(stat.value, i, total)
        return point.x + ',' + point.y
      .join(' ')

  methods:
    valueToPoint: (value, index, total)->
      x     = 0
      y     = -value * 0.8
      angle = Math.PI * 2 / total * index
      cos   = Math.cos(angle)
      sin   = Math.sin(angle)
      tx    = x * cos - y * sin + 100
      ty    = x * sin + y * cos + 100
      return { x: tx, y: ty }


</script>

<style lang="sass">
@import src/styles/main

#our-story

  .portraits
    width: 100%
    padding: 0 50px
    +flexbox
    +align-content(row)
    +justify-content(space-between)
    .portrait
      vertical-align: top
      display: inline-block
      position: relative
      width: 250px

      .image-container
        width: 100%
        height: 300px
        border: 1px solid white
        overflow: hidden
        position: relative
        &::after
          content: ''
          width: 100%
          height: 100%
          display: block
          position: absolute
          bottom: 0
          background: linear-gradient(transparentize($screen-background,1) 50%, transparentize(darken($screen-background,10),0.75) 50%), linear-gradient(90deg,transparentize(#ff0000,0.94),transparentize(#00ff00,0.98),transparentize(#0000ff,0.94))
          z-index: 9999
          background-size: 100% 3px, 2px 100%
          pointer-events: none
        &:hover > img.normal
          opacity: 0
          +transition(.5s ease all)
        img
          position: absolute
          top: 0
          left: 0
          cursor: pointer
          &.normal
            opacity: 1
            z-index: 99
            +transition(.5s ease all)
          &.dark
            z-index: 9

      .about
        margin-top: 20px


</style>
