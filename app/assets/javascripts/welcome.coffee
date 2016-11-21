# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blocks = mainScene.children

$(window).scroll(
  () ->
    if $(blocks[1]).is(':off-top')
      height = blocks[0].height
      block = $(blocks[0]).remove()
      document.body.scrollTop -= height
      mainScene.appendChild(block[0]) if block.attr('class') == 'block'
    console.log($('#block1').is(':off-top'))
    console.log($(window).scrollTop())
)
