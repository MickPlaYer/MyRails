this.maps = new Vue ->
  el: 'maps'
  data:
    maps: []
    newMap: {}
  methods:
    getMaps: () ->
      console.log("TEST!")
# Need to rails create model Map to continue
