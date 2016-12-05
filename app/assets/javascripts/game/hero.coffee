#= require game/item_list

class this.Hero
  walkTimer: null
  itemList: new ItemList
  id: 0
  status:
    name: ''
    hp: 0
    atk: 0
    def: 0

  update: () ->
    clearTimeout(@walkTimer)
    @walkTimer = setTimeout(
      () ->
        $('#heroImage').css('background-image', 'url(\'/imgs/hero.png\')')
      1000
    )
    $('#heroImage').css('background-image', 'url(\'/imgs/hero_walk.gif\')')

  pickUpItem: (id, item) ->
    effect = @itemList.identifyItem(id)
    return unless effect
    pickUpEffect = effect.pickUp
    changed = []
    `for (value in pickUpEffect) {
      if (pickUpEffect[value] != 0) {
        this.status[value] += pickUpEffect[value];
        changed.push(value);
      }
    }`
    @updateStatus(changed)

  updateStatus: (changed) ->
    self = this
    data = {}
    changed.forEach((value) ->
      data[value] = self.status[value]
    )
    console.log(data)
    $.ajax(
      method: 'PUT'
      url: "hero/#{@id}.json"
      data:
        hero: data
    )

this.hero = new Hero
Debug.itemList = hero.itemList

this.hero_vue = new Vue
  el: '#mainUI'
  data:
    status: hero.status
  methods:
    getHero: () ->
      that = this
      this.$http.get('/hero.json').then(
        (response) ->
          status = that.status
          status.name = response.data.name
          status.hp = response.data.hp
          status.atk = response.data.atk
          status.def = response.data.def
          hero.id = response.data.id
      )
    logout: () ->
      window.location = '/logout'
