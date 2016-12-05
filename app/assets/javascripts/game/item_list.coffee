class this.ItemList
  items: {}

  constructor: () ->
    that = this
    $.ajax(
      method: "GET"
      url: "item.json"
      success: (list) ->
        list.forEach((e) ->
          delete e.created_at
          delete e.updated_at
          try
            e.effect = JSON.parse(e.description)
            consle.log(JSON.parse(e.description))
          that.items[e.id] = e
        )
    )

  identifyItem: (id) ->
    return @items[id].effect
