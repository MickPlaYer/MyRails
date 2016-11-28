class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admins = Admin.all
    respond_to do |format|
      format.html
      format.json { render :json => @admins }
    end
  end

  def update
    return no_privilege unless current_admin.privilege
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.json do
        if @admin.update(admin_params)
          @admin.save
          render :json => @admin
        else
          render :json => { :errors => @admin.errors.messages }, :status => 422
        end
      end
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:privilege)
  end

  def no_privilege
    message = I18n.t(:devise)[:failure][:privilege]
    return render json: { error: message }, :status => 422
  end
end
