class CourseSection < ApplicationRecord
  has_many :course_menus, dependent: :destroy
  has_many :menus, through: :course_menus
  has_many :posts, through: :course_menus
end
