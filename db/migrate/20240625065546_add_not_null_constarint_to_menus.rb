class AddNotNullConstarintToMenus < ActiveRecord::Migration[7.0]
  def change
    change_column_null :menus, :menu_name, false
    change_column_null :menus, :price, false
    change_column_null :menus, :menu_no, false
  end
end
