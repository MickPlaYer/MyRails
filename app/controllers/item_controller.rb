class ItemController < ApplicationController
  before_action :authenticate_admin_privilege!, except: :index

  def index
    @items = Item.all
    respond_to do |format|
      format.html { authenticate_admin_privilege! }
      format.json { render :json => @items }
    end
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      format.json do
        if @item.save
          render :json => @item
        else
          render :json => { :errors => @item.errors.messages }, :status => 422
        end
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      format.json do
        if @item.update(item_params)
          render :json => @item
        else
          render :json => { :errors => @item.errors.messages }, :status => 422
        end
      end
      format.image do
        image = params[:image].pack 'c*'
        item_image = 'public/imgs/items'
        file_name = params[:id] + '.png'
        file_path = Rails.root.join(item_image, file_name)
        File.open(file_path, 'wb') do |file|
          file.write(image)
        end
        result = Cloudinary::Uploader.upload(file_path, public_id: "items/#{params[:id]}")
        @item.image = result['secure_url']
        @item.save
        render :json => @item
      end
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    respond_to do |format|
      format.json { render :json => {}, :status => :no_content }
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
