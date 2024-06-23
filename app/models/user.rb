class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :passwordm length: { minimum: 5}, if: -> { new_record? || changes[:crypted_password]}
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presee: true, uniquness: true

end
