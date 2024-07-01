class Menu < ApplicationRecord
  has_many :post_menus
  has_many :posts, through: :post_menus

  validates :menu_name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :menu_no, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["menu_name", "price", "menu_no"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["posts", "post_menus"]
  end
end
