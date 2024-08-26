class AddUserAvatorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avator, :string
  end
end
