
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
