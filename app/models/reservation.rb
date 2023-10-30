class Reservation < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :trade
  validates :user_id, uniqueness: { scope: %i[trade_id date] }
end
