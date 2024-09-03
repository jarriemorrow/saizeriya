class CreateArrangeMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :arrange_menus do |t|
      t.references :post, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
