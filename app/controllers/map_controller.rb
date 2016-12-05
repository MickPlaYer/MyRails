class MapController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: { items: [ 27, 27, 1 ] }
      end
    end
  end
end
