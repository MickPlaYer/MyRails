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

  def authenticate_admin_privilege!
    return authenticate_admin! if current_admin.privilege if current_admin
    respond_to do |format|
      message = I18n.t(:devise)[:failure][:privilege]
      format.html { render 'admin/no_privilege', layout: :default }
      format.json { render json: { error: message } }
    end
  end
end
