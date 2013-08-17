$ ->
  appendHeader = (header)->
    appendText("\n◎#{header}")

  appendText = (text)->
    $textarea = $('#menu-text')
    originalText = $textarea.text()
    $('#menu-text').text("#{originalText}#{text}\n")

  $('.menu-items').on 'click', '.menu-item', ->
    $this = $(this)
    appendText($this.text())

  $('#categories').on 'click', '.category-name', ->
    $this = $(this)
    appendHeader($this.text())
