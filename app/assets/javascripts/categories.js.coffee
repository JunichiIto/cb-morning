$ ->
  appendHeader = (header)->
    appendText("\n#{header}")

  appendText = (text)->
    $textarea = $('#menu-text')
    originalText = $textarea.val()
    $('#menu-text').val("#{originalText}#{text}\n")

  $('.menu-items').on 'click', '.menu-item', ->
    $this = $(this)
    appendText($this.text())

  $('#categories').on 'click', '.category-name', ->
    $this = $(this)
    appendHeader($this.text())

  $('#edit-container').on 'click', '#clear-text', ->
    $textarea = $('#menu-text')
    $textarea.text("")

  $("#q_category_id_eq").on 'change', ->
    $(this).closest('form').submit()
