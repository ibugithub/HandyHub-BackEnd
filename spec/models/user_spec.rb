# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it 'without a role, is assigned to user role by default' do
    user = build(:user, role: nil)
    user.save
    expect(user.role).to eq('user')
  end

  it 'is not an admin by default' do
    user = FactoryBot.build(:user)
    expect(user.admin?).to be_falsey
  end

  it 'can have an admin role' do
    user = FactoryBot.build(:user, role: 'admin')
    expect(user.admin?).to be_truthy
  end
end
