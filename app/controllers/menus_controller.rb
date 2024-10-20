class MenusController < ApplicationController
  skip_before_action :require_login, only: [:search, :search_post]
  def search
    query = params[:query]
    @menus = Menu.where(status: :active).where('menu_name LIKE ?', "%#{query}%").limit(10)
    render json: @menus
  end

  def search_post
    query = params[:query]
    @menus = Menu.joins(:arrange_menus, :course_menus, :pairing_menus)
                 .where(menu_status: :active)
                 .distinct
                 .where("menus.name LIKE ?", "%#{params[:query]}%")
    render json: @menus.pluck(:name)
  end
end
