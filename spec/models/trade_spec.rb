require 'rails_helper'

RSpec.describe Trade, type: :model do
  # Validation tests
  it 'is valid with valid attributes' do
    user = FactoryBot.create(:user)
    trade = FactoryBot.build(:trade, user:)
    expect(trade).to be_valid
  end

  it 'is not valid without a name' do
    trade = FactoryBot.build(:trade, name: nil)
    expect(trade).to_not be_valid
  end

  it 'is not valid without a description' do
    trade = FactoryBot.build(:trade, description: nil)
    expect(trade).to_not be_valid
  end

  it 'is not valid without a location' do
    trade = FactoryBot.build(:trade, location: nil)
    expect(trade).to_not be_valid
  end

  it 'is not valid without a price' do
    trade = FactoryBot.build(:trade, price: nil)
    expect(trade).to_not be_valid
  end

  it 'is not valid without a duration' do
    trade = FactoryBot.build(:trade, duration: nil)
    expect(trade).to_not be_valid
  end

  # Association tests
  it 'should belong to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'should have many reservations' do
    association = described_class.reflect_on_association(:reservations)
    expect(association.macro).to eq :has_many
  end
end
