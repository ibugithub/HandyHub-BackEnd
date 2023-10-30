class Trade < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :name, :description, :location, :price, :duration, presence: true
end
