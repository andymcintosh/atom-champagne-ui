{$} = require 'atom'

module.exports =
  configDefaults:
    allowTreeViewToScrollHorizontally: false

  activate: (state) ->
      atom.config.observe 'champagne-ui.allowTreeViewToScrollHorizontally', ->
        if atom.config.get('champagne-ui.allowTreeViewToScrollHorizontally')
          $('.tree-view-scroller').addClass('tree-view-scrolls-horizontally')
        else
          $('.tree-view-scroller').removeClass('tree-view-scrolls-horizontally')

      useragent = navigator.userAgent

      if matches = useragent.match(/Mac OS X 10_([0-9]+)_[0-9]+/i)
        version = parseInt(matches[1], 10)
        osstyle = if version >= 10 then 'champagne-mac-new' else 'champagne-mac-old'
        $(document.body).addClass osstyle

      $(window).on 'resize', @checkFullscreen

      @checkFullscreen()

  checkFullscreen: ->
    if $(window).height() + 1 >= screen.height
      atom.workspaceView.addClass 'champagne-ui-fullscreen'
    else
      atom.workspaceView.removeClass 'champagne-ui-fullscreen'
