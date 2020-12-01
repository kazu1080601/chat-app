class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users, dependent: :destroy
  validates :name, presence: true
  has_many :messages, dependent: :destroy
end
