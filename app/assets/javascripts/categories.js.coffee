$ ->
  appendHeader = (header)->
    if header.match /菓子パン/
      appendText(header)
    else
      appendText("\n#{header}")

  appendText = (text)->
    $textarea = $('#menu-text')
    originalText = $textarea.val()
    $('#menu-text').val("#{originalText}#{text}\n")

  appendPrice = (text)->
    textWithPrice = text
    if text.match /菓子パン/
      textWithPrice += '（250円）'
    else if text.match /スコーン/
      textWithPrice += '（180円）'
    else if text.match /ベーグル/
      textWithPrice += '（250円）'
    else if text.match /フォカッチャ/
      textWithPrice += '（800円※）'
    else if text.match /食パン/
      textWithPrice += '（700円～800円※）'
    else if text.match /バゲット/
      textWithPrice += '（350円～500円）'
    else if text.match /ハードパン/
      textWithPrice += '（400円）'
    else if text.match /カンパーニュ/
      textWithPrice += '（800円※）'
    textWithPrice

  $('.menu-items').on 'click', '.menu-item', ->
    $this = $(this)
    appendText($this.text())

  $('#categories').on 'click', '.category-name', ->
    $this = $(this)
    appendHeader(appendPrice($this.text()))

  $('#edit-container').on 'click', '#clear-text', ->
    $textarea = $('#menu-text')
    $textarea.text("")

  $("#q_category_id_eq").on 'change', ->
    $(this).closest('form').submit()
