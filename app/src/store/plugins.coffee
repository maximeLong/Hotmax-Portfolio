module.exports =

  init: (store)=>
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
