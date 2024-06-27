class DropOldMenus < ActiveRecord::Migration[7.0]
  def change
    drop_table :menus_posts
  end
end
