class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :name, presence: true
  has_many :reservations, dependent: :destroy
  has_many :trades, through: :reservations

  before_create :set_default_role
  def set_default_role
    self.role ||= 'user'
  end

  def admin?
    role == 'admin'
  end
end
