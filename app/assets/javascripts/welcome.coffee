# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blockHeight = 600
mainViewMargin = ($(window).height() - blockHeight) / 2
mainViewMargin -= mainViewMargin % 2
mainSceneTop = mainViewMargin + blockHeight
mainScene2Top = mainSceneTop + blockHeight

this.showMainScene = () ->
  $('#mainScene').show()
  $('#mainScene2').show()
  $('#scrollAble').show()

$(window).ready(
  () ->
    $('#startScene').css('top', mainViewMargin + 'px')
    $('#mainScene').css('top', mainSceneTop + 'px')
    $('#mainScene2').css('top', mainScene2Top + 'px')
    $('#footer').css('top', mainViewMargin + blockHeight + 'px')
)

$(window).scroll(
  () ->
    delta = document.body.scrollTop
    document.body.scrollTop = 0
    mainSceneTop -= delta
    mainScene2Top -= delta
    if mainSceneTop <= -blockHeight
      mainSceneTop += blockHeight * 2
      $('#startScene').hide()
    if mainScene2Top <= -blockHeight
      mainScene2Top += blockHeight * 2
    $('#mainScene').css('top', mainSceneTop + 'px')
    $('#mainScene2').css('top', mainScene2Top + 'px')
)
