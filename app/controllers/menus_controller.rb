class MenusController < ApplicationController
  def search
    query = params[:query]
    @menus = Menu.where('menu_name LIKE ?', "%#{query}%").limit(10)
    render json: @menus
  end
end
