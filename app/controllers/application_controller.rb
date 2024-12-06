class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success

  private

  def not_authenticated
    flash[:danger] = 'ログインしてください'
    redirect_to login_path
  end
end
