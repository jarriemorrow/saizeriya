class MenusController < ApplicationController
  skip_before_action :require_login, only: [:search, :search_post]
  def search
    query = params[:query]
    @menus = Menu.where(status: :active).where('menu_name LIKE ?', "%#{query}%").limit(10)
    render json: @menus
  end

  def search_post
    query = params[:query]
    @menus = Menu.left_outer_joins(:arrange_menus, :course_menus, :pairing_menus)
      .select('menus.id, menus.menu_name')
      .where('menus.menu_name LIKE ?', "%#{query}%")
      .where('arrange_menus.menu_id IS NOT NULL OR course_menus.menu_id IS NOT NULL OR pairing_menus.menu_id IS NOT NULL')
      .distinct
      .limit(10)
    render json: @menus.map { |menu| { id: menu.id, menu_name: menu.menu_name } }
  end
end
