<template>
  <transition appear name="fade">
  <div id="projects-panel">
    <div class="icon-grid">
      <div @click="openNavigatorWindow(navigatorWindows.rubbish)" class="icon rubbish">
        <img src="../assets/rubbish-icon.svg">
        <div class="caption">Rubbish Bin</div>
      </div>
      <div @click="openOverlay(overlays.readme)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">readme.pdf</div>
      </div>
      <div @click="openProjectWindow(projectWindows.curriculum)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Choices Curriculum</div>
      </div>
      <div @click="openProjectWindow(projectWindows.video)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Video Portal</div>
      </div>
      <div @click="openProjectWindow(projectWindows.curriculum)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Whereyaat Social</div>
      </div>
    </div>

    <!-- project window -->
    <div class="window-container" v-if="projectWindowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::Our Work >> ' + activeProjectWindow.shortTitle"
        :realTitle="activeProjectWindow.realTitle"
        :type="'portfolio'">

        <div class="banner">
          <img :src="'../static/banners/' + activeProjectWindow.bannerImg">
          <div class="title">{{activeProjectWindow.realTitle}}</div>
        </div>
        <div class="content">
          <component v-bind:is="activeProjectWindow.component"></component>
        </div>

      </window>
    </div>

    <!-- navigator window TODO: make more general -->
    <div class="window-container navigator" v-if="navigatorWindowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::' + activeNavigatorWindow.shortTitle"
        :type="'navigator'">
        <div class="content icon-grid">

          <div @click="openOverlay(overlays.resume)" class="icon file">
            <img src="../assets/file-icon.svg">
            <div class="caption">resume.pdf</div>
          </div>
          <div @click="openOverlay(overlays.asteroids)" class="icon file">
            <img src="../assets/file-icon.svg">
            <div class="caption">asteroids.exe</div>
          </div>

        </div>
      </window>
    </div>

  </div>
  </transition>
</template>

<script lang="coffee">
interact = require('interact.js')

module.exports =
  name: 'projectsPanel'
  components:
    Window: require './Window'

    #content components
    DigitalTextbook: require '../projects/DigitalTextbook'
    VideoPortal: require '../projects/VideoPortal'


  data: ->
    projectWindows:
      curriculum:
        bannerImg:  'boulder.svg'
        component:  'DigitalTextbook'
        shortTitle: 'Digital Textbook'
        realTitle:  'Choices Group Digital Curriculum'
        readme:     'some description about the choices textbook site'
      video:
        bannerImg:  'stick-figure.svg'
        component:  'VideoPortal'
        shortTitle: 'Video Portal'
        realTitle:  'Choices Group Video Portal'
        readme:     'some description about the choices video portal'

    navigatorWindows:
      rubbish:
        shortTitle: 'Rubbish Bin'
        readMe: ''

    overlays:
      readme:
        title: 'readme.txt'
      resume:
        title: 'resume.txt'
      asteroids:
        title: 'asteroids.exe'

  methods:
    openProjectWindow: (view)->
      @$store.commit 'SET_PROJECT_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_PROJECT_WINDOW', view
    openOverlay: (view)->
      @$store.commit 'SET_OVERLAY_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_OVERLAY', view
    openNavigatorWindow: (view)->
      @$store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_NAVIGATOR_WINDOW', view
  computed:
    #vuex
    projectWindowIsOpen: -> return @$store.state.projectWindowIsOpen
    activeProjectWindow: -> return @$store.state.activeProjectWindow
    navigatorWindowIsOpen: -> return @$store.state.navigatorWindowIsOpen
    activeNavigatorWindow: -> return @$store.state.activeNavigatorWindow



</script>

<style lang="sass">
@import src/styles/main

#projects-panel
  position: relative
  +flex(1 1 50%)
  +flexbox
  height: 100%
  +align-items(center)
  +flex-direction(column)
  +justify-content(center)

  .window-container
    width: 88%
    height: 90%
    z-index: 99
    background-color: white
    position: relative
    .banner
      width: 100%
      height: 150px
      position: relative
      +flexbox
      +justify-content(middle)
      +align-items(center)
      img
        position: absolute
        height: 100%
        width: 100%
        background-color: $action_color
      .title
        z-index: 99
        text-align: center
        margin: 0 auto
        background-color: $ink_black
        padding: 20px
        color: white

    .content
      padding: 30px
      height: calc(100% - 150px)
      width: 100%
    &.navigator
      position: absolute
      +translate3d(-30px, -60px, 0)
      width: 60%
      height: 50%
      .icon-grid
        .icon
          &:nth-child(1)
            +translate3d(0px, 40px, 0)
          &:nth-child(2)
            +translate3d(180px, 80px, 0)

  .icon-grid
    position: absolute
    top: 50px
    left: 50px
    width: 50%
    .icon
      position: absolute
      +clickable
      &:nth-child(2)
        +translate3d(110px, 40px, 0)
      &:nth-child(3)
        +translate3d(0, 220px, 0)
      &:nth-child(4)
        +translate3d(130px, 250px, 0)
      &:nth-child(5)
        +translate3d(260px, 220px, 0)
      // &:nth-child(6)
      //   +translate3d(40px, 520px, 0)

      .caption
        padding: 5px 0 0 10px
        line-height: 16px
      &.rubbish
        width: 65px
      &.folder
        width: 75px
      &.file
        width: 57px


</style>
