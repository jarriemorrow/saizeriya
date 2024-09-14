class MenusController < ApplicationController
  def find
    menu = Menu.find_by(menu_no: params[:menu_no])
    render json: { menu: menu }
  end
end
