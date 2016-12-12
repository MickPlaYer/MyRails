class MapController < ApplicationController
  before_action :authenticate_admin_privilege!, except: :index

  def index
    respond_to do |format|
      format.html { authenticate_admin_privilege! }
      format_json format
    end
  end

  private

  def format_json format
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
