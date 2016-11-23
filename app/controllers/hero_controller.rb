class HeroController < ApplicationController
  before_action :authenticate_user!

  def index
    @hero = Hero.find_by user_id: current_user.id
    if @hero.nil?
      @hero = Hero.new user_id: current_user.id
      unless @hero.save
        render :json => { :errors => @hero.errors.messages }, :status => 422
      end
    end
    render :json => @hero
  end
end
