Vuex = require('vuex')
{ init } = require('./plugins')

state = {
  windowIsOpen: false
  activeWindow: {}
}

mutations =
  SET_WINDOW_IS_OPEN: (state, status)->
    state.windowIsOpen = status
  SET_ACTIVE_WINDOW: (state, window)->
    state.activeWindow = window


module.exports = new Vuex.Store({
  state
  mutations
  actions: require './actions'
  strict: process.env.NODE_ENV != 'production'
})
