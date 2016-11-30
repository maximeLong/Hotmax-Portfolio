<template>
  <div id="desktop-panel">
    <div id="icon-grid">
      <div @click="openWindow(windows.curriculum)" class="icon rubbish">
        <img src="../assets/rubbish-icon.svg">
        <div class="caption">Rubbish Bin</div>
      </div>
      <div @click="openWindow(windows.video)" class="icon folder">
        <img src="../assets/folder-icon.svg">
        <div class="caption">Video Portal</div>
      </div>
    </div>

    <div class="window-container" v-if="windowIsOpen">
      <window
        :canClose="true"
        :shortTitle="'::Maxime Long >> Portfolio >> ' + activeWindow.shortTitle"
        :realTitle="activeWindow.realTitle"
        >
        <div class="content">some content</div>
      </window>
    </div>

  </div>
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

  methods:
    openWindow: (view)->
      @$store.commit 'SET_WINDOW_IS_OPEN', true
      @$store.commit 'SET_ACTIVE_WINDOW', view
  computed:
    windowIsOpen: -> return @$store.state.windowIsOpen
    activeWindow: -> return @$store.state.activeWindow

  created: ->
    interact('.window-container')
      .styleCursor(false)
      .draggable({
        inertia: true,
        restrict: {
          restriction: "parent",
          endOnly: true,
          elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
        }
        autoScroll: true,
        onmove: (event)->
          target = event.target
          x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
          y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
          target.style.webkitTransform = 'translate(' + x + 'px, ' + y + 'px)'
          target.style.transform =       'translate(' + x + 'px, ' + y + 'px)'
          target.setAttribute('data-x', x)
          target.setAttribute('data-y', y)
      })

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

  #icon-grid
    position: absolute
    top: 50px
    left: 50px
    width: 50%
    .icon
      display: inline-block
      margin-right: 50px
      +clickable
      .caption
        padding: 5px 0 0 10px
        line-height: 16px
      &.rubbish
        width: 65px
      &.folder
        width: 75px


</style>
