class Post < ApplicationRecord
  mount_uploaders :images, PostUploader
  belongs_to :user
  has_many :post_menus, dependent: :destroy
  has_many :course_menus, dependent: :destroy
  has_many :course_related_menus, through: :course_menus, source: :menu
  has_many :course_sections, through: :course_menus, source: :course_section
  has_many :arrange_menus, dependent: :destroy
  has_many :arrange_related_menus, through: :arrange_menus, source: :menu
  has_many :pairing_menus, dependent: :destroy
  has_many :pairing_related_menus, through: :pairing_menus, source: :menu

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :post_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :course_menus, allow_destroy: true, reject_if: proc { |attributes| attributes['menu_id'].blank? }
  accepts_nested_attributes_for :arrange_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :pairing_menus, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :post_tags, allow_destroy: true
  
  validate :only_one_menu_type
  validate :menu_presence
  validates :body, presence: true
  validates :recipe_name, presence: true
  after_save :assign_tag_based_on_saved_data

  # メニューの合計値計算
  def total_price
    course_menu_sum = CourseMenu.joins(:menu).where(post_id: id).sum('menus.price')
    arrange_menu_sum = ArrangeMenu.joins(:menu).where(post_id: id).sum('menus.price')
    pairing_menu_sum = PairingMenu.joins(:menu).where(post_id: id).sum('menus.price')
    course_menu_sum + arrange_menu_sum + pairing_menu_sum
  end
  

  # 検索可能な属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["recipe_name", "body"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course_related_menus", "arrange_related_menus", "pairing_related_menus", "tags"]
  end

  # マルチ検索機能
  def self.search_multiple_keywords(keywords)
    return all if keywords.blank?
    ransack_conditions = keywords.map do |keyword|
      Post.ransack(
        recipe_name_or_body_or_course_related_menus_menu_name_or_arrange_related_menus_menu_name_or_pairing_related_menus_menu_name_or_tags_name_cont: keyword
      ).result(distinct: true)
    end
  
    ransack_query = ransack_conditions.reduce(&:merge)
    ransack_query
  end
  
  def first_image_url
    if images.present? && images[0].present?
      images[0].url
    else
      PostUploader.new.default_url # デフォルト画像のURLを返す
    end
  end

  private

  def only_one_menu_type
    if (arrange_menus.any? && (pairing_menus.any? || course_menus.any?)) ||
       (pairing_menus.any? && course_menus.any?)
      errors.add(:base, "You can only select one type of menu.")
    end
  end

  def menu_presence
    unless arrange_menus.any? || pairing_menus.any? || course_menus.any?
      errors.add(:base, "At least one menu must be selected.")
    end
  end

  def assign_tag_based_on_saved_data
    if arrange_menus.exists?
      tag = Tag.find_or_create_by(name: 'アレンジ')
    elsif pairing_menus.exists?
      tag = Tag.find_or_create_by(name: 'ペアリング')
    elsif course_menus.exists?
      tag = Tag.find_or_create_by(name: 'コース')
    end
    if tag && !self.post_tags.exists?(tag_id: tag.id)
      self.post_tags.create(tag: tag)
    end
  end
end
