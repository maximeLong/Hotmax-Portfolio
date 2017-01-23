Vuex = require('vuex')
{ init } = require('./plugins')

state =
  # entry to desktop toggles
  entryIsOpen: true
  showThreeGlitch: false

  projectPanelVisibility: false
  consolePanelVisibility: false

  # project, navigator, and overlay window statuses
  projectWindowIsOpen: false
  activeProjectWindow: {}

  navigatorWindowIsOpen: false
  activeNavigatorWindow: {}

  overlayIsOpen: false
  activeOverlay: {}


mutations =
  SET_ENTRY_IS_OPEN: (state, status)->
    state.entryIsOpen = status
  SET_PROJECT_PANEL_VISIBILITY: (state, status)->
    state.projectPanelVisibility = status
  SET_CONSOLE_PANEL_VISIBILITY: (state, status)->
    state.consolePanelVisibility = status

  SET_PROJECT_WINDOW_IS_OPEN: (state, status)->
    state.projectWindowIsOpen = status
  SET_ACTIVE_PROJECT_WINDOW: (state, project)->
    state.activeProjectWindow = project

  SET_OVERLAY_IS_OPEN: (state, status)->
    state.overlayIsOpen = status
  SET_ACTIVE_OVERLAY: (state, overlay)->
    state.activeOverlay = overlay

  SET_NAVIGATOR_WINDOW_IS_OPEN: (state, status)->
    state.navigatorWindowIsOpen = status
  SET_ACTIVE_NAVIGATOR_WINDOW: (state, project)->
    state.activeNavigatorWindow = project

  SET_THREE_GLITCH: (state, mode)->
    state.showThreeGlitch = mode


module.exports = new Vuex.Store({
  state
  mutations
  plugins: [init]
  actions: require './actions'
  strict: process.env.NODE_ENV != 'production'
})
