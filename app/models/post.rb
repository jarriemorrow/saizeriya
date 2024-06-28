class Post < ApplicationRecord
  belongs_to :user
  has_many :post_menus
  has_many :menus, through: :post_menus
  has_many :post_tags
  has_many :tags, through: :post_tags
end
