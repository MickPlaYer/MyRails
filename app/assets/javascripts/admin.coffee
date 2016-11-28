
this.admins = new Vue
  el: '#admins'
  data: () ->
    admins: []
  methods:
    getAdmins: () ->
      that = this
      this.$http.get('admin.json').then(
        (res) ->
          that.admins = res.data
      )
  components:
    'admin-row':
      template: '#admin-row'
      props:
        admin: Object
      data: () ->
        editMode: false
        errors: {}
        error: ''
      methods:
        edit: () ->
          that = this
          url = '/admin/' + this.admin.id + '.json'
          this.$http.put(url, admin: this.admin).then(
            (res) ->
              that.errors = {};
              that.editMode = false;
            (res) ->
              that.error = res.data.error
              that.errors = res.data.errors
          )
        remove: () ->
          that = this
          url = '/item/' + this.admin.id + '.json'
          this.$http.delete(url).then(
            (res) ->
              that.$parent.admins.splice(
                that.$parent.admins.findIndex(
                  (e) ->
                    e.id == that.admin.id
                )
                1
              )
          )

this.admins.getAdmins()
