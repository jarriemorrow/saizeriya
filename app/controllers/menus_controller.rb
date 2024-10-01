class MenusController < ApplicationController
  skip_before_action :require_login, only: [:search]
  def search
    query = params[:query]
    @menus = Menu.where('menu_name LIKE ?', "%#{query}%").limit(10)
    render json: @menus
  end
end
