module.exports =

  init: (store)=>
    #mobile check
    mobile = 800
    desktop = 1280
    do widthCheck = ()=>
      WIDTH = window.innerWidth
      # console.log WIDTH
      switch
        when (WIDTH <= mobile) then store.commit 'SET_PORT', 'mobile'
        when (WIDTH > mobile) and (WIDTH <= desktop) then store.commit 'SET_PORT', 'tablet'
        else store.commit 'SET_PORT', 'desktop'

    window.addEventListener 'resize', ()=>
      widthCheck()
      # console.log WIDTH


    #canvas check
    canvas = document.createElement('canvas')
    webglContextParams = ['webgl', 'experimental-webgl', 'webkit-3d', 'moz-webgl']
    webglContext = null
    for context in webglContextParams
      try
        webglContext = canvas.getContext context
        if webglContext
          break
      catch error
        console.log error

    if webglContext is null
      console.log 'WebGL is not supported on your browser, and you should see something less taxing.'
      #TODO: add some visual fallback for this case
      store.commit 'SET_WEBGL_IS_WORKING', false
    else
      console.log 'WebGL is supported on your browser, and life is good.'
      store.commit 'SET_WEBGL_IS_WORKING', true
