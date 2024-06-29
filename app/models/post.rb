class Post < ApplicationRecord
  belongs_to :user
  has_many :post_menus
  has_many :menus, through: :post_menus
  has_many :post_tags
  has_many :tags, through: :post_tags

  #メニューの合計値計算
  def total_price
    menus.sum(:price)
  end
end
