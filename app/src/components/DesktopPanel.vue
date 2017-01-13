<template>
  <transition appear name="fade">
  <div id="desktop-panel">
    <div class="icon-grid">
      <div @click="openNavigator" class="icon rubbish">
        <img src="../assets/rubbish-icon.svg">
        <div class="caption">Rubbish Bin</div>
      </div>
      <div @click="openPdf(pdf.readme)" class="icon file">
        <img src="../assets/file-icon.svg">
        <div class="caption">readme.pdf</div>
      </div>
      <div @click="openWindow(windows.curriculum)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Choices Curriculum</div>
      </div>
      <div @click="openWindow(windows.video)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Video Portal</div>
      </div>
      <div @click="openWindow(windows.curriculum)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Whereyaat Social</div>
      </div>
    </div>

    <div class="window-container" v-if="windowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::Portfolio >> ' + activeWindow.shortTitle"
        :realTitle="activeWindow.realTitle"
        :type="'portfolio'">
        <div class="content">some content</div>
      </window>
    </div>

    <div class="window-container navigator" v-if="navigatorIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::Rubbish Bin'"
        :type="'navigator'">
        <div class="content icon-grid">

          <div @click="openPdf(pdf.readme)" class="icon file">
            <img src="../assets/file-icon.svg">
            <div class="caption">resume.pdf</div>
          </div>

          <div @click="openPdf(pdf.readme)" class="icon file">
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
  name: 'desktopPanel'
  components:
    Window: require './Window'

  data: ->
    windows:
      curriculum:
        shortTitle: 'Digital Textbook'
        realTitle:  'Choices Digital Curriculum'
      video:
        shortTitle: 'Video Portal'
        realTitle:  'Choices Video Portal'
    pdf:
      readme:
        context: null
        title: 'readme.txt'

  methods:
    openWindow: (view)->
      @$store.commit 'SET_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_WINDOW', view
    openPdf: (view)->
      @$store.commit 'SET_PDF_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_PDF', view
    openNavigator: (view)->
      @$store.commit 'SET_NAVIGATOR_IS_OPEN', true
  computed:
    windowIsOpen: -> return @$store.state.windowIsOpen
    navigatorIsOpen: -> return @$store.state.navigatorIsOpen
    activeWindow: -> return @$store.state.activeWindow

  # created: ->
  #   interact('.window-container')
  #     .styleCursor(false)
  #     .draggable({
  #       inertia: true,
  #       restrict: {
  #         restriction: "#body-container",
  #         endOnly: true,
  #         elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
  #       }
  #       autoScroll: true,
  #       onmove: (event)->
  #         target = event.target
  #         x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
  #         y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
  #         target.style.webkitTransform = 'translate3d(' + x + 'px, ' + y + 'px, 0)'
  #         target.style.transform =       'translate3d(' + x + 'px, ' + y + 'px, 0)'
  #         target.setAttribute('data-x', x)
  #         target.setAttribute('data-y', y)
  #     })

</script>

<style lang="sass">
@import src/styles/main

#desktop-panel
  position: relative
  +flex(1 1 50%)
  +flexbox
  height: 100%
  +align-items(center)
  +flex-direction(column)
  +justify-content(center)

  .window-container
    width: 75%
    height: 80%
    z-index: 99
    background-color: white
    position: relative
    .content
      padding: 30px
      height: 100%
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
