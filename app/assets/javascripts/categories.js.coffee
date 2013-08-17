$ ->
  appendText = (text)->
    $textarea = $('#menu-text')
    originalText = $textarea.text()
    $('#menu-text').text("#{originalText}#{text}\n")

  $('.menu-items').on 'click', '.menu-item', ->
    $this = $(this)
    appendText($this.text())
