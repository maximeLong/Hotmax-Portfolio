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


  # portfolio, project, navigator, and overlay window statuses
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


  # console state
  overflowConsoleIsOpen:  false
  normalConsoleIsOpen:    false
  normalConsoleText:    {}
  overflowConsoleText:  {}
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
    portfolio:
      title:      'Portfolio.txt'
      type:       'text'
      component:  'PortfolioText'


  # portfolio options
  portfolioWindowIsOpen: false
  activePortfolioOption: 'All'
  portfolioOptions: [ 'All', 'UI Design', 'Sound Design', 'App Dev.', 'VR', 'AR' ]

  # projects
  projectWindowIsOpen: false
  activeProjectWindow: {}
  projectWindows:
    arSynth:
      content:    'ArSynth'
      readme:     'ArSynthReadme'
      key:        'arSynth'
      meta:
        tags: ['All', 'Sound Design', 'App Dev.', 'AR']
        bannerImg:  'synth.png'
        shortTitle: 'AR Synth'
        realTitle:  'AR Synth - Mobile Synthesizer'
        date:       'December 2016'
        client:     'Self Published on iOS store'
    curriculum:
      content:    'DigitalTextbook'
      readme:     'DigitalTextbookReadme'
      key:        'curriculum'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'textbook.png'
        shortTitle: 'Interactive Textbook'
        realTitle:  'Choices Interactive Textbook'
        client:     'The Choices Program at Brown University'
        date:       'June 2016'
    video:
      content:    'VideoPortal'
      readme:     'VideoPortalReadme'
      key:        'video'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'video.png'
        shortTitle: 'Scholar Video'
        realTitle:  'Academic Video App'
        client:     'Brown University Web Services'
        date:       'May 2016'
    whereyaat:
      content:    'Whereyaat'
      readme:     'WhereyaatReadme'
      key:        'whereyaat'
      meta:
        tags: ['All', 'UI Design', 'App Dev.', 'AR']
        bannerImg:  'whereyaat.png'
        shortTitle: 'Whereyaat'
        realTitle:  'Whereyaat - Geographic Social Network'
        client:     'Self Published'
        date:       'Ongoing'
    # walkthrough:
    #   content:    'Walkthrough'
    #   readme:     'WalkthroughReadme'
    #   key:        'walkthrough'
    #   meta:
    #     tags: ['All', 'VR', 'App Dev.']
    #     bannerImg:  'walkthrough.png'
    #     shortTitle: 'VR Navigation'
    #     realTitle:  'VR Stage Design Navigation'
    #     date:       'January 2017'
    translation:
      content:    'Translation'
      readme:     'TranslationReadme'
      key:        'translation'
      meta:
        tags: ['All', 'UI Design', 'App Dev.']
        bannerImg:  'translation.png'
        shortTitle: 'Translation Portfolio'
        realTitle:  'CMS Translation Portfolio'
        client:     'Lizzie Davis, Coffee House Press'
        date:       'January 2017'


mutations =

  SET_PORTFOLIO_WINDOW_IS_OPEN: (state, status)->
    state.portfolioWindowIsOpen = status
  SET_ACTIVE_PORTFOLIO_OPTION: (state, opt)->
    state.activePortfolioOption = opt

  SET_PROJECT_WINDOW_IS_OPEN: (state, status)->
    state.projectWindowIsOpen = status
  SET_ACTIVE_PROJECT_WINDOW: (state, project)->
    state.activeProjectWindow = project

  SET_NORMAL_CONSOLE_IS_OPEN: (state, status)->
    state.normalConsoleIsOpen = status
  SET_NORMAL_CONSOLE_TEXT: (state, text)->
    state.normalConsoleText = text
  SET_OVERFLOW_CONSOLE_IS_OPEN: (state, status)->
    state.overflowConsoleIsOpen = status
  SET_OVERFLOW_CONSOLE_TEXT: (state, text)->
    state.overflowConsoleText = text

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
  TOGGLE_SOUND: (state, sound)->
    state.soundIsOn = sound
  SET_SYSTEM_COLOR: (state, color)->
    state.systemColor = color
  SET_WEBGL_IS_WORKING: (state, status)->
    state.webGlIsWorking = status

  SET_ENTRY_INDEX: (state, index)->
    state.entryIndex = index
  SET_PROJECT_PANEL_VISIBILITY: (state, status)->
    state.projectPanelVisibility = status
  SET_CONSOLE_PANEL_VISIBILITY: (state, status)->
    state.consolePanelVisibility = status


module.exports = new Vuex.Store({
  state
  mutations
  plugins: [init]
  actions: require './actions'
  strict: process.env.NODE_ENV != 'production'
})
