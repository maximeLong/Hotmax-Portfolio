<template>
  <div id="portfolio">

    <transition-group name="list">
      <div class="portfolio-item" v-for="project in tagFiltered" :key="project.key">

        <div @click="openProjectWindow(project)" class="group">
          <div class="portfolio-image"></div>
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
      .portfolio-image
        width: 100%
        border: 2px solid $console_black
        height: 100%
      .caption
        width: calc(100% + 20px)
        margin-top: 10px
        padding-left: 7px
        line-height: 16px


</style>
