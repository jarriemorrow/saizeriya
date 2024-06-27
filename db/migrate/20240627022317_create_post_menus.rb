class CreatePostMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :post_menus do |t|
      t.references :post, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
