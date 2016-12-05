#= require game/hero
#= require game/game_map
#= require game/user_vue

UI =
  shown: false

$(window).scroll(
  () ->
    gameMap.update()
    hero.update()
  )

this.showUI = () ->
  if !UI.shown
    $('#startScene').hide()
    $('#mainUI').fadeIn()
    UI.shown = true

this.start = (form) ->
  hero_vue.getHero()
  $(form).fadeOut(
    done: () ->
      $('#welcomeMessage').fadeIn()
      $('#mainScene').show()
  )

user_vue.signIn(':pre')
