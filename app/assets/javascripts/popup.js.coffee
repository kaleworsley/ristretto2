window.addPopup = (popup, select = null) ->

  $('#popup').dialog('close');
  $('#popup').remove();

  if typeof popup.length == "undefined"
    $('<div id="popup" />').append('<div id ="popup-' + popup.id + '" />').load(popup.content + ' #content').dialog(
      title: popup.title
      draggable: false
      position: [25, 70]
      width: $(window).width() - 400
      height: $(window).height() - 95
      resizable: false
      open: (event, ui)->
        popupButtons($('#popup-' + popup.id))
        $('body').addClass('popup')
      close: (event, ui)->
        $('body').removeClass('popup')
    )

  else
    popup_div = $('<div id="popup" />')
    popup_div.append('<ul />')
    _.each(popup, (item)->
      popup_div.find('ul').append('<li><a href="#popup-' + item.id + '">' + item.title + '</a></li>')
      $('<div id ="popup-' + item.id + '" />').load(item.content + ' #content').appendTo(popup_div);
      null
    )
    popup_div.tabs(
      select: (event, ui)->
        popupButtons(ui.panel)
      enable: (event, ui)->
        popupButtons(ui.panel)
    ).dialog(
      draggable: false
      position: [25, 70]
      width: $(window).width() - 400
      height: $(window).height() - 95
      resizable: false
      open: (event, ui)->
        popupButtons($('#popup-' + popup.id))
        $('body').addClass('popup')
      close: (event, ui)->
        $('body').removeClass('popup')

    )
    popup_div.tabs('select', select)

window.popupButtons = (el) ->
  window.buttons = {}

  $(el).find(':button, input[type=submit]').each(->
    b = $(this);
    window.buttons[b.attr('value')] = ->
      b.click();
  )
  $('#popup').dialog('option', 'buttons', window.buttons);

