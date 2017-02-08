Vuex = require('vuex')
{ init } = require('./plugins')

state =
  # entry to desktop toggles
  webGlIsWorking: true
  entryIndex: 0
  showThreeGlitch: false
  systemColor: ''
  soundIsOn: true

  projectPanelVisibility: false
  consolePanelVisibility: false

  # project, navigator, and overlay window statuses
  overlayIsOpen: false
  activeOverlay: {}
  overlays:
    asteroids:
      title: 'asteroids.exe'
      orientation: 'portrait'

  navigatorWindowIsOpen: false
  activeNavigatorWindow: {}
  navigatorWindows:
    rubbish:
      content:    'RubbishBin'
      shortTitle: 'Rubbish Bin'
      readMe: ''
    portfolio:
      content:    'Portfolio'
      shortTitle: 'Portfolio'
      readMe: ''

  consoleTextIsOpen: false
  activeConsoleText: {}
  consoleTexts:
    aboutUs:
      title:      'About Us.txt'
      type:       'text'
      component:  'OurStory'
    ourServices:
      title:      'Our Services.txt'
      type:       'text'
      component:  'OurServices'
    contactUs:
      title:      'Contact Us.txt'
      type:       'text'
      component:  'OurContact'


  # portfolio options
  activePortfolioOption: 'All'
  portfolioOptions: [ 'All', 'UI Design', 'Sound Design', 'App Dev.', 'VR', 'AR' ]

  # projects
  projectWindowIsOpen: false
  activeProjectWindow: {}
  projectWindows:
    arSynth:
      content:    'ArSynth'
      readme:     'ArSynthReadme'
      meta:
        tags: ['All', 'Sound Design', 'App Dev.', 'AR']
        bannerImg:  'video.png'
        shortTitle: 'AR Synth'
        realTitle:  'AR Synth - Mixed Reality Music App'
        date:       'December 2016'
    curriculum:
      content:    'DigitalTextbook'
      readme:     'DigitalTextbookReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'video.png'
        shortTitle: 'Interactive Textbook'
        realTitle:  'Interactive Textbook App'
        client:     'The Choices Program at Brown University'
        date:       'June 2016'
    video:
      content:    'VideoPortal'
      readme:     'VideoPortalReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'video.png'
        shortTitle: 'Scholar Video'
        realTitle:  'Scholar Video Portal'
        client:     'Brown University Web Services'
        date:       'May 2016'
    whereyaat:
      content:    'Whereyaat'
      readme:     'WhereyaatReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.', 'AR']
        bannerImg:  'video.png'
        shortTitle: 'Whereyaat'
        realTitle:  'Whereyaat - Social App'
        client:     'The Choices Program at Brown University'
        date:       'Ongoing'
    walkthrough:
      content:    'Walkthrough'
      readme:     'WalkthroughReadme'
      meta:
        tags: ['All', 'VR', 'App Dev.']
        bannerImg:  'video.png'
        shortTitle: 'VR Walkthrough'
        realTitle:  'Gear VR - Immersive Stage Design'
        date:       'January 2017'
    translation:
      content:    'Translation'
      readme:     'TranslationReadme'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'video.png'
        shortTitle: 'Translation Portfolio'
        realTitle:  'Node CMS - Portfolio'
        date:       'January 2017'


mutations =
  TOGGLE_SOUND: (state, sound)->
    state.soundIsOn = sound

  SET_SYSTEM_COLOR: (state, color)->
    state.systemColor = color

  SET_ACTIVE_PORTFOLIO_OPTION: (state, opt)->
    state.activePortfolioOption = opt

  SET_WEBGL_IS_WORKING: (state, status)->
    state.webGlIsWorking = status

  SET_ENTRY_INDEX: (state, index)->
    state.entryIndex = index
  SET_PROJECT_PANEL_VISIBILITY: (state, status)->
    state.projectPanelVisibility = status
  SET_CONSOLE_PANEL_VISIBILITY: (state, status)->
    state.consolePanelVisibility = status

  SET_PROJECT_WINDOW_IS_OPEN: (state, status)->
    state.projectWindowIsOpen = status
  SET_ACTIVE_PROJECT_WINDOW: (state, project)->
    state.activeProjectWindow = project

  SET_CONSOLE_TEXT_IS_OPEN: (state, status)->
    state.consoleTextIsOpen = status
  SET_ACTIVE_CONSOLE_TEXT: (state, text)->
    state.activeConsoleText = text

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
