Vuex = require('vuex')
{ init } = require('./plugins')

state = {
  windowIsOpen: false
  activeWindow: {}

  pdfIsOpen: false
  activePdf: {}

  navigatorIsOpen: false
}

mutations =
  SET_WINDOW_IS_OPEN: (state, status)->
    state.windowIsOpen = status
  SET_ACTIVE_WINDOW: (state, win)->
    state.activeWindow = win

  SET_PDF_IS_OPEN: (state, status)->
    state.pdfIsOpen = status
  SET_ACTIVE_PDF: (state, pdf)->
    state.activePdf = pdf

  SET_NAVIGATOR_IS_OPEN: (state, status)->
    state.navigatorIsOpen = status


module.exports = new Vuex.Store({
  state
  mutations
  actions: require './actions'
  strict: process.env.NODE_ENV != 'production'
})
