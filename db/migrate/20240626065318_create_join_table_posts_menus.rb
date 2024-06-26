class CreateJoinTablePostsMenus < ActiveRecord::Migration[7.0]
  def change
    create_join_table :menus, :posts do |t|
      # t.index [:menu_id, :post_id]
      # t.index [:post_id, :menu_id]
    end
  end
end
