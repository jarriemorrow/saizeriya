class Post < ApplicationRecord
  belongs_to :user
  has_many :post_menus, dependent: :destroy
  has_many :course_menus, dependent: :destroy
  has_many :course_related_menus, through: :course_menus, source: :menu
  has_many :arrange_menus, dependent: :destroy
  has_many :arrange_related_menus, through: :arrange_menus, source: :menu
  has_many :pairing_menus, dependent: :destroy
  has_many :pairing_related_menus, through: :pairing_menus, source: :menu

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :post_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :course_menus, allow_destroy: true
  accepts_nested_attributes_for :arrange_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :pairing_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :post_tags, allow_destroy: true
  
  # メニューの合計値計算
  def total_price
    Menu.joins(:course_menus)
        .where(course_menus: { post_id: id })
        .sum(:price) +
    Menu.joins(:arrange_menus)
        .where(arrange_menus: { post_id: id })
        .sum(:price) +
    Menu.joins(:pairing_menus)
        .where(pairing_menus: { post_id: id })
        .sum(:price)
  end

  # 検索可能な属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["recipe_name", "body"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course_related_menus", "arrange_related_menus", "pairing_related_menus", "tags"]
  end

  def add_tag(tag_id)
    if tag_id.present?
      tag = Tag.find(tag_id)
      self.tags << tag
    end
  end
  
end
