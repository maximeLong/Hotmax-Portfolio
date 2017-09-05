Vuex = require('vuex')
{ init } = require('./plugins')

state =
  # entry to desktop toggles
  port: ''
  webGlIsWorking: true
  entryIndex: 1
  entryRoute: ''

  showThreeGlitch: false
  soundIsOn: true

  projectPanelVisibility: false
  consolePanelVisibility: false


  # overlay normally is defined on ProjectImage -- for special overlays they are defined here
  # activeOverlay is set from action
  overlayIsOpen: false
  activeOverlay: {}
  overlays:
    asteroids:
      title: 'asteroids.exe'
      orientation: 'portrait'

  #navigator windows are small window containers -- basically only rubbish at the moment
  navigatorWindowIsOpen: false
  activeNavigatorWindow: {}
  navigatorWindows:
    rubbish:
      content:    'RubbishBin'
      shortTitle: 'Rubbish Bin'
      readMe: ''


  # console states
  # infoConsoleText is set from actions
  infoConsoleIsOpen:    false
  infoConsoleText:    {}
  consoleTexts:
    aboutUs:
      title:      'About Us.txt'
      type:       'text'
      component:  'OurStory'
      orientation: 'portrait'
    ourServices:
      title:      'Our Services.txt'
      type:       'text'
      component:  'OurServices'
      orientation: 'portrait'
    contactUs:
      title:      'Contact Us.txt'
      type:       'text'
      component:  'OurContact'
      orientation: 'portrait'
    portfolio:
      title:      'Portfolio.txt'
      type:       'text'
      component:  'PortfolioText'
      orientation: 'portrait'

  # portfolio options
  portfolioWindowIsOpen: false
  activePortfolioOption: 'All'
  portfolioOptions: [ 'All', 'UI Design', 'Sound Design', 'App Dev.', 'VR', 'AR' ]


  # portfolio projects, and info -- eventually should be moved out to another file
  projectWindowIsOpen: false
  activeProjectWindow: {}
  projectWindows:
    virtualSets:
      content:    'VirtualSets'
      readme:     'VirtualSetsReadme'
      key:        'virtualSets'
      meta:
        tags: ['All', 'UI Design', 'App Dev.', 'VR', 'AR', 'Sound Design']
        bannerImg:  'virtualSets.png'
        shortTitle: 'Virtual Sets'
        realTitle:  'Virtual Set Design'
        client:     'Ongoing colloboration with Reid Santabarbara Designs'
        date:       'August 2017'
    arSynth:
      content:    'ArSynth'
      readme:     'ArSynthReadme'
      key:        'arSynth'
      meta:
        tags: ['All', 'Sound Design', 'App Dev.', 'AR']
        bannerImg:  'synth.png'
        shortTitle: 'AR Synth'
        realTitle:  'AR Synth - Synthesizer App'
        date:       'Early 2018'
        client:     'Self Published early 2018'
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
    # translation:
    #   content:    'Translation'
    #   readme:     'TranslationReadme'
    #   key:        'translation'
    #   meta:
    #     tags: ['All', 'UI Design', 'App Dev.']
    #     bannerImg:  'translation.png'
    #     shortTitle: 'Translation Portfolio'
    #     realTitle:  'CMS Translation Portfolio'
    #     client:     'Lizzie Davis, Coffee House Press'
    #     date:       'January 2017'


mutations =
  SET_PORT: (state, type)->
    state.port = type

  SET_PORTFOLIO_WINDOW_IS_OPEN: (state, status)->
    state.portfolioWindowIsOpen = status

  SET_ACTIVE_PORTFOLIO_OPTION: (state, opt)->
    state.activePortfolioOption = opt

  SET_PROJECT_WINDOW_IS_OPEN: (state, status)->
    state.projectWindowIsOpen = status
  SET_ACTIVE_PROJECT_WINDOW: (state, project)->
    state.activeProjectWindow = project

  SET_INFO_CONSOLE_IS_OPEN: (state, status)->
    state.infoConsoleIsOpen = status
  SET_INFO_CONSOLE_TEXT: (state, text)->
    state.infoConsoleText = text

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
  SET_WEBGL_IS_WORKING: (state, status)->
    state.webGlIsWorking = status

  SET_ENTRY_INDEX: (state, index)->
    state.entryIndex = index
  SET_ENTRY_ROUTE: (state, route)->
    state.entryRoute = route

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
