<template>
  <div id="portfolio">

    <transition-group name="list">
      <div class="portfolio-item"
           v-for="project in tagFiltered"
           :key="project.key"
           @click="openProjectWindow(project)">

          <div class="margin-container">
            <div class="portfolio-image" :style="{ backgroundImage: 'url(../static/banners/' + project.meta.bannerImg + ')' }" ></div>
            <div class="info-container">
              <div class="caption">
                <div class="movement-container">{{project.meta.realTitle}}</div>
              </div>
            </div>
          </div>

      </div>
    </transition-group>

  </div>
</template>

<script lang="coffee">
_ = require 'lodash'
module.exports =
  name: 'portfolio'

  methods:
    openProjectWindow: (view)->
      @$store.dispatch 'openProjectWindow', view

  computed:
    tagFiltered: ->
      filteredCollection = []
      for k,project of @projectWindows
        if _.includes(project.meta.tags, @activePortfolioOption)
          filteredCollection.push(project)
      return filteredCollection

    #vuex
    projectWindows: ->        return @$store.state.projectWindows
    portfolioOptions: ->      return @$store.state.portfolioOptions
    activePortfolioOption: -> return @$store.state.activePortfolioOption


</script>

<style lang="sass">
@import src/styles/main


#portfolio
  padding: 30px
  +screen(mobile)
    padding: 10px

  .portfolio-item
    display: inline-block
    vertical-align: top
    width: 50%
    height: 17vw
    margin-left: -1px
    margin-bottom: -1px
    overflow: hidden
    +transition(.5s ease all)
    +clickable
    +screen(mobile)
      width: 100%
      height: 30vw
    +screen(tablet)
      height: 30vw

    .margin-container
      height: 100%
      width: 100%
      position: relative

      &:hover > .portfolio-image
        +scale(1.05)
        +transition(.9s ease all)
      &:hover > .portfolio-image::after
        opacity: .3
        +transition(.6s linear opacity)
      &:hover > .info-container .caption
        opacity: 1
        +transition(.6s ease opacity)
      &:hover > .info-container .caption .movement-container
        +translate3d(0,0,0)
        +transition(.6s ease all)

      .portfolio-image
        width: 100%
        height: 100%
        background-repeat: no-repeat
        background-size: cover
        background-position: center center
        +scale(1)
        +transition(.9s ease all)
        transition-delay: .5s
        position: relative
        &::after
          content: ''
          position: absolute
          top: 0
          left: 0
          width: 100%
          height: 100%
          background-color: black
          opacity: 0
          +transition(.6s linear opacity)


      .info-container
        position: absolute
        top: 0
        left: 0
        width: 100%
        height: 100%
        padding: 0 10%
        +flexbox
        +align-items(center)
        +justify-content(center)

        .caption
          opacity: 0
          overflow: hidden
          padding: 20px
          +headerType(normal)
          background-color: black
          font-size: 30px
          +transition(.6s linear opacity)
          +screen(mobile)
            display: none
          +screen(tablet)
            display: none
          .movement-container
            width: 100%
            height: 100%
            +translate3d(0, 120%,0)
            +transition(.9s ease all)



</style>
