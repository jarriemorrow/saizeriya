class ChangeImagesToJsonbInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :images, :jsonb, default: []
  end
end
