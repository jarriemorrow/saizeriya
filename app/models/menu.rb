class Menu < ApplicationRecord
  has_many :post_menus
  validates :menu_name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :menu_no, presence: true, uniqueness: true
end
