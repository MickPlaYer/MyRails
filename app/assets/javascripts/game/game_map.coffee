class this.GameMap
  blocks: blockSet.children

  constructor: (@hero) ->

  update: () ->
    if $(@blocks[1]).is(':off-top')
      height = @blocks[0].height
      block = $(@blocks[0]).remove()
      document.body.scrollTop -= height
      if block.attr('class') == 'block'
        @updateBlock(block[0])
      showUI()

  updateBlock: (block) ->
    self = this
    $.ajax(
      url: '/map.json'
      method: 'GET'
      success: (e) ->
        self.addObject(block, e)
      complete: (e) ->
        blockSet.appendChild(block)
    )

  addObject: (block, objects) ->
    self = this
    items = block.getElementsByClassName('items')[0]
    items.remove() if items
    items = document.createElement('div')
    items.className = 'items'
    objects.items.forEach((value, index) ->
      item = self.createItem(value, index)
      items.appendChild(item)
    )
    block.appendChild(items)

  createItem: (value, index) ->
    self = this
    item = document.createElement('div')
    item.className = 'item'
    item.onclick = () ->
      return if this.picked
      this.picked = true
      $(this).fadeOut(() ->
        $(this).show()
        $(this).css('background-image', '')
        $(this).css('z-index', -1)
      )
      self.hero.pickUpItem(value, this)
    $(item).css('background-image', @getItemImage(value))
    $(item).css('top', Math.floor(Math.random() * (150 - 16)) * 4)
    $(item).css('left', Math.floor(Math.random() * (200 - 16)) * 4)
    $(item).css('margin-top', -64) if index != 0
    return item

  getItemImage: (id) ->
    return "url(#{Cloudinary.url}#{id}.png)"

this.gameMap = new GameMap(this.hero)
