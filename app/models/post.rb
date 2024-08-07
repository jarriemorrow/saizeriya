class Post < ApplicationRecord
  belongs_to :user
  has_many :post_menus, dependent: :destroy
  has_many :menus, through: :post_menus
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :post_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :post_tags, allow_destroy: true

  # メニューの合計値計算
  def total_price
    menus.sum(:price)
  end

  # 検索可能な属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["recipe_name", "body"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["menus", "tags"]
  end
end
