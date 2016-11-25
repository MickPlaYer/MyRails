# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blocks = blockSet.children

UI =
  shown: false

hero =
  walkTimer: null
  isWalking: false

$(window).scroll(
  () ->
    updateBlock()
    updateHero()
  )

updateBlock = () ->
  if $(blocks[1]).is(':off-top')
    height = blocks[0].height
    block = $(blocks[0]).remove()
    document.body.scrollTop -= height
    blockSet.appendChild(block[0]) if block.attr('class') == 'block'
    showUI() if !UI.shown

updateHero = () ->
  clearTimeout(hero.walkTimer)
  hero.walkTimer = setTimeout(
    () ->
      $('#hero').css('background-image', 'url(\'/imgs/hero.png\')')
      hero.isWalking = false
    1000
  )
  return if hero.isWalking
  $('#hero').css('background-image', 'url(\'/imgs/hero_walk.gif\')')
  hero.isWalking = true

showUI = () ->
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

this.user_vue = new Vue
  el: '#startScene'
  data:
    user:
      id: -1
      email: ''
      password: ''
      password_confirmation: ''
    error: ''
  methods:
    signIn: ( tag ) ->
      that = this
      this.$http.post('/users/sign_in', { user: this.user }).then(
        (response) ->
          current_user = response.data
          that.user.id = current_user.id
          that.user.email = current_user.email
          start('#signInForm')
        (response) ->
          that.error = response.data.error if tag != ':pre'
      )
    signUp: () ->
      that = this
      this.$http.post('/users', { user: this.user }).then(
        (response) ->
          current_user = response.data
          that.user.id = current_user.id
          that.user.email = current_user.email
          start('#signUpForm')
        (response) ->
          $.each(response.data.errors, (key, arr) ->
            $.each(arr, (index, value) ->
              that.error += key + " " + value + "\n"
            )
          )
      )
    showSignUp: () ->
      this.error = ''
      $('#signInForm').fadeOut(
        done: () ->
          $('#signUpForm').fadeIn()
      )
    showSignIn: () ->
      this.error = ''
      $('#signUpForm').fadeOut(
        done: () ->
          $('#signInForm').fadeIn()
      )

this.hero_vue = new Vue
  el: '#mainUI'
  data:
    name: ''
    hp: 0
    atk: 0
    def: 0
  methods:
    getHero: () ->
      that = this
      this.$http.get('/hero').then(
        (response) ->
          console.log(response)
          that.name = response.data.name
          that.hp = response.data.hp
          that.atk = response.data.atk
          that.def = response.data.def
      )
    logout: () ->
      window.location = '/logout'

user_vue.signIn(':pre')
