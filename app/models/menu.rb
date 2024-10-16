class Menu < ApplicationRecord
  enum status: {active: 0, inactive: 1}
  has_many :post_menus, dependent: :destroy
  has_many :posts, through: :post_menus
  has_many :arrange_menus, dependent: :destroy
  has_many :course_menus, dependent: :destroy
  has_many :course_sections, through: :course_menus
  has_many :pairing_menus, dependent: :destroy

  validates :menu_name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :menu_no, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["menu_name", "price", "menu_no"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["posts", "arrange_menus", "course_menus", "pairing_menus"]
  end
end
