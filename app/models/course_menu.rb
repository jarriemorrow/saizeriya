class CourseMenu < ApplicationRecord
  belongs_to :post
  belongs_to :menu
  belongs_to :course_section
end
