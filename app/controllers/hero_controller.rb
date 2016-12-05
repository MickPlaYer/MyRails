class HeroController < ApplicationController
  before_action :authenticate_user!

  def index
    @hero = Hero.find_by user_id: current_user.id
    if @hero.nil?
      @hero = Hero.new user_id: current_user.id
      unless @hero.save
        render :json => { :errors => @item.errors.messages }, :status => 422
      end
    end
    render :json => @hero
  end

  def update
    @hero = Hero.find_by user_id: current_user.id
    if @hero.id != params['id'].to_i
      return render :json => { :error => "Hero not match current user." }
    end
    if @hero.update(hero_params)
      render :json => @hero
    else
      render :json => { :errors => @item.errors.messages }, :status => 422
    end
  end

  private

  def hero_params
    params.require(:hero).permit(:name, :hp, :atk, :def)
  end
end
