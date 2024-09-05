class CourseSection < ApplicationRecord
  has_many :course_menus
  has_many :menus, through: :course_menus
end
