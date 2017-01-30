Vuex = require('vuex')
{ init } = require('./plugins')

state =
  # entry to desktop toggles
  webGlIsWorking: true
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
  overlays:
    readme:
      title: 'readme.txt'
    aboutUs:
      title: 'About Us.txt'
    ourServices:
      title: 'Our Services.txt'
    contactUs:
      title: 'Contact Us.txt'
    resume:
      title: 'resume.txt'
    asteroids:
      title: 'asteroids.exe'

  # portfolio options
  activePortfolioOption: 'All'
  portfolioOptions: [ 'All', 'UI Design', 'Sound Design', 'App Dev.', 'VR', 'AR' ]

  # projects
  projectWindows:
    arSynth:
      content:    'ArSynth'
      readme:     'ArSynthReadme'
      meta:
        tags: ['All', 'Sound Design', 'App Dev.', 'AR']
        bannerImg:  'stick-figure.svg'
        shortTitle: 'AR Synth'
        realTitle:  'AR Synth'
        date:       'December 2016'
    curriculum:
      content:    'DigitalTextbook'
      readme:     'DigitalTextbookReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'textbook.png'
        shortTitle: 'Interactive Textbook'
        realTitle:  'Choices Interactive Textbook'
        client: 'The Choices Program at Brown University'
        date:       'June 2016'
    whereyaat:
      content:    'Whereyaat'
      readme:     'WhereyaatReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.', 'AR']
        bannerImg:  'boulder.svg'
        shortTitle: 'Whereyaat'
        realTitle:  'Whereyaat Geographic Social App'
        date:       'Ongoing'
    walkthrough:
      content:    'Walkthrough'
      readme:     'WalkthroughReadme'
      meta:
        tags: ['All', 'VR', 'App Dev.']
        bannerImg:  'stick-figure.svg'
        shortTitle: 'VR Walkthrough'
        realTitle:  'Occulus VR - Immersive Stage Design'
        date:       'January 2017'
    video:
      content:    'VideoPortal'
      readme:     'VideoPortalReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'stick-figure.svg'
        shortTitle: 'Academic Video'
        realTitle:  'Academic Video Portal'
        date:       'May 2016'
    translation:
      content:    'Translation'
      readme:     'TranslationReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'stick-figure.svg'
        shortTitle: 'Translation Portfolio'
        realTitle:  'CMS Translation Portfolio'
        date:       'January 2017'
    ibes:
      content:    'Ibes'
      readme:     'IbesReadme'
      meta:
        tags: ['All', 'UI Design']
        bannerImg:  'stick-figure.svg'
        shortTitle: 'IBES'
        realTitle:  'Environmental Group Landing Redesign'
        date:       'March 2016'


mutations =
  SET_ACTIVE_PORTFOLIO_OPTION: (state, opt)->
    state.activePortfolioOption = opt

  SET_WEBGL_IS_WORKING: (state, status)->
    state.webGlIsWorking = status

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
