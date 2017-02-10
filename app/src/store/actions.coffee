module.exports =

  openOverflowConsole: (store, overflowView)->
    #overflow console opens its view and closes things on the left-hand side
    store.commit 'SET_OVERFLOW_CONSOLE_IS_OPEN', true
    store.commit 'SET_OVERFLOW_CONSOLE_TEXT', overflowView

    store.commit 'SET_NORMAL_CONSOLE_IS_OPEN', false
    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', false
    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', false


  openPortfolio: (store)->
    #portfolio opens itself, its consoleText, and closes overFlow if it's open
    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', true
    store.commit 'SET_NORMAL_CONSOLE_IS_OPEN', true
    store.commit 'SET_NORMAL_CONSOLE_TEXT', store.state.consoleTexts.portfolio

    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', false
    store.commit 'SET_OVERFLOW_CONSOLE_IS_OPEN', false


  openProjectWindow: (store, projectView)->
    #project opens itself, its readmeText, and closes overFlow if it's open
    store.commit 'SET_PROJECT_WINDOW_IS_OPEN', true
    store.commit 'SET_ACTIVE_PROJECT_WINDOW', projectView
    store.commit 'SET_NORMAL_CONSOLE_IS_OPEN', true
    # console.log store.state.projectWindows, projectView
    store.commit 'SET_NORMAL_CONSOLE_TEXT', store.state.projectWindows[projectView.key]

    store.commit 'SET_PORTFOLIO_WINDOW_IS_OPEN', false
    store.commit 'SET_OVERFLOW_CONSOLE_IS_OPEN', false
