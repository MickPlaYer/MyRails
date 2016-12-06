class MapController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        @items = Item.all if @item.nil?
        items = []
        3.times do
          items << @items.sample.id
        end
        render json: { items: items }
      end
    end
  end
end
