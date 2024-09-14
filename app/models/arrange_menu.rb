class ArrangeMenu < ApplicationRecord
  belongs_to :post
  belongs_to :menu
  attr_accessor :menu_name
end
