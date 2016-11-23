# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blocks = blockSet.children
UI = {
  shown: false
}

$(window).scroll(
  () ->
    updateBlock()
    # console.log($(window).scrollTop())
)

updateBlock = () ->
  if $(blocks[1]).is(':off-top')
    height = blocks[0].height
    block = $(blocks[0]).remove()
    document.body.scrollTop -= height
    blockSet.appendChild(block[0]) if block.attr('class') == 'block'
    showUI()

this.start = () ->
  $('#loginForm').fadeOut(
    done: () ->
      $('#welcomeMessage').fadeIn()
      $('#mainScene').show()
  )

showUI = () ->
  if !UI.shown
    $('#startScene').hide()
    $('#mainUI').fadeIn()
    UI.shown = true

this.user = new Vue
  el: '#startScene'
  data:
    user:
      id: -1
      email: ''
      password: ''
    error: ''
  methods:
    login: () ->
      that = this
      this.$http.post('/users/sign_in', { user: this.user }).then(
        (response) ->
          console.log(response)
          current_user = response.data
          that.user.id = current_user.id
          that.user.email = current_user.email
          start()
        (response) ->
          console.log(response)
          that.error = response.data.error
      )

this.hero = new Vue
  el: '#mainUI'
  data: {}
  methods:
    logout: () ->
      window.location = '/logout'

user.login()
