
module.exports =

  openPortfolio: (store)->
    #portfolio opens itself, its consoleText, and closes overFlow if it's open
    console.log 'what the fuck this actino should fire'

    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', true

    store.commit 'SET_INFO_CONSOLE_IS_OPEN', true
    store.commit 'SET_INFO_CONSOLE_TEXT', store.state.consoleTexts.portfolio
    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', false

    store.commit 'SET_OVERLAY_IS_OPEN', false


  openServicesOverlay: (store, overlayView)=>
    store.commit 'SET_OVERLAY_IS_OPEN', true
    store.commit 'SET_ACTIVE_OVERLAY', overlayView

    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', false
    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', false


  openProjectWindow: (store, projectView)->
    #project opens itself, its readmeText, and closes portfolio window behind it
    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', true
    store.commit 'SET_ACTIVE_PROJECT_WINDOW', projectView

    store.commit 'SET_INFO_CONSOLE_IS_OPEN', true
    store.commit 'SET_INFO_CONSOLE_TEXT', projectView

    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', false
    store.commit 'SET_OVERLAY_IS_OPEN', false


  openLandingHub: (store)->
    store.commit 'SET_OVERLAY_IS_OPEN', false
    store.commit 'SET_NAVIGATOR_WINDOW_IS_OPEN', false
    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', false
    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', false
