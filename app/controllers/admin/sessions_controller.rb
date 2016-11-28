class Admin::SessionsController < Devise::SessionsController

  protected

  # def after_sign_up_path_for resource
  #   redirect_to '/item'
  # end

  def after_sign_out_path_for resource
    item_index_path
  end

  def after_sign_in_path_for resource
    item_index_path
  end
end
