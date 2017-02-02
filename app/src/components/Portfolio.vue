<template>
  <div id="portfolio">

    <transition-group name="list">
      <div class="portfolio-item" v-for="project in tagFiltered" :key="project.key">

        <div @click="openProjectWindow(project)" class="group">
          <div class="portfolio-image-container">
            <div class="portfolio-image">
              <img :src="'../static/banners/' + project.meta.bannerImg">
            </div>
          </div>
          <div class="caption">{{project.meta.realTitle}}</div>
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
      @$store.commit 'SET_PROJECT_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_PROJECT_WINDOW', view

      @$store.commit 'SET_CONSOLE_TEXT_IS_OPEN', false
      @$store.commit 'SET_ACTIVE_CONSOLE_TEXT', {}

  computed:
    tagFiltered: ->
      filteredCollection = []
      for k,project of @projectWindows
        if _.includes(project.meta.tags, @activePortfolioOption)
          project.key = k
          filteredCollection.push(project)
      return filteredCollection


    #vuex
    projectWindows: ->        return @$store.state.projectWindows
    portfolioOptions: ->      return @$store.state.portfolioOptions
    activePortfolioOption: -> return @$store.state.activePortfolioOption


</script>

<style lang="sass">
@import src/styles/main

@keyframes flicker
  $steps: 20
  @for $i from 0 through $steps
    #{percentage($i*(1/$steps))}
      opacity: random()



#portfolio
  padding: 30px

  .portfolio-item
    display: inline-block
    margin-right: 40px
    vertical-align: top
    +transition(.5s ease all)
    +clickable
    .group
      width: 100px
      height: 100px
      margin-bottom: 100px
      .portfolio-image-container
        width: 100px
        height: 100px
        position: relative
        .portfolio-image
          width: 100%
          height: 100%
          position: relative
          overflow: hidden
          +translate3d(10px, -10px, 0)
          img
            height: 100%
            width: auto
        &::before
          content: ''
          display: block
          position: absolute
          top: 0
          left: 0
          bottom: 0
          right: 0
          background: linear-gradient(transparentize($screen-background,1) 50%, transparentize(darken($screen-background,10),0.75) 50%), linear-gradient(90deg,transparentize(#ff0000,0.94),transparentize(#00ff00,0.98),transparentize(#0000ff,0.94))
          z-index: 2
          background-size: 100% 3px, 2px 100%
          pointer-events: none

      .caption
        width: calc(100% + 20px)
        margin-top: 10px
        padding-left: 7px
        line-height: 16px


</style>
