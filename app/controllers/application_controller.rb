class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      respond_to do |format|
        format.html { redirect_to '/' }
        format.json { super }
      end
    end
  end
end
