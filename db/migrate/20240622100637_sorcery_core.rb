class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    if table_exists?(:users)
      # 既存のテーブルにカラムを追加する
      add_column :users, :crypted_password, :string
      add_column :users, :salt, :string
    else
      # 新しいテーブルを作成する
      create_table :users do |t|
        t.string :email, null: false
        t.string :crypted_password
        t.string :salt
        t.timestamps null: false
      end
      add_index :users, :email, unique: true
    end
  end
end
