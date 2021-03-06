var items = new Vue({
  el: '#items',
  data: {
    items: [],
    item: {
      name: '',
      description: ''
    },
    errors: {}
  },
  methods: {
    queryItems: function () {
      var that = this;
      this.$http.get('/item.json').then(
        function (response) {
          that.items = response.data;
        }
      );
    },
    addItem: function () {
      var that = this;
      this.$http.post('/item.json', { item: this.item }).then(
        function(response) {
          that.errors = {}
          that.item.name = '';
          that.item.description = '';
          that.items.push(response.data);
        },
        function(response) {
          that.errors = response.data.errors;
        }
      );
    },
    removeItem: function (item) {
      var index = this.items.findIndex(
        function (i) {
          return i.id == item.id;
        }
      );
      if (index > -1) {
        this.items.splice(index, 1);
      }
    }
  }
});

Vue.component('item-row', {
  template: '#item-row',
  props: {
    item: Object
  },
  data: function () {
    return {
      editMode: false,
      errors: {}
    }
  },
  methods: {
    editItem: function () {
      var that = this;
      var url = '/item/' + this.item.id + '.json';
      this.$http.put(url, { item: this.item }).then(
        function(response) {
          that.errors = {};
          that.item.name = response.data.name;
          that.item.description = response.data.description;
          that.editMode = false;
        },
        function(response) {
          that.errors = response.data.errors;
        }
      );
    },
    removeItem: function () {
      var that = this;
      var url = '/item/' + this.item.id + '.json';
      this.$http.delete(url).then(
        function(response) {
          items.removeItem(that.item);
        }
      );
    },
    uploadImage: function () {
      var that = this
      $('#filePicker').off('change');
      $('#filePicker').on('change', function(){
        var url = '/item/' + that.item.id + '.image';
        var file = filePicker.files[0];
        var fileReader = new FileReader();
        fileReader.onload = function () {
          var binaryArray = new Int8Array(fileReader.result)
          var array = []
          $.each(binaryArray, function( index, value ) {
            array.push(value)
          });
          that.$http.put(url, { image: array }).then(
            function(response) {
              window.location = 'item'
            }
          )
        }
        fileReader.readAsArrayBuffer(file);
        $('#filePicker').val('')
      })
      $('#filePicker').click()
    }
  }
});
var debug = {}
items.queryItems();
