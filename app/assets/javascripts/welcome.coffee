# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

this.showMainScene = () ->
  $('#mainScene').show();

$( window ).scroll(
  () ->
    console.log(document.body.scrollTop)
    if document.body.scrollTop >= 600
      $('#startBlock').hide()
)
