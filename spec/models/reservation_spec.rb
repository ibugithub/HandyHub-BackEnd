require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before(:each) do
    @user = create(:user)
    @trade = create(:trade)
    @city = 'dhaka'
    @reservation = Reservation.new(user_id: @user.id, trade_id: @trade.id, date: Date.today, city: @city)
  end

  it 'is valid with valid attributes' do
    expect(@reservation).to be_valid
  end

  it 'is not valid without a user_id' do
    @reservation.user_id = nil
    expect(@reservation).not_to be_valid
  end

  it 'is not valid without a trade_id' do
    @reservation.trade_id = nil
    expect(@reservation).not_to be_valid
  end

  it 'belongs to the user' do
    expect(@reservation.user).to eq(@user)
  end

  it 'belongs to the trade' do
    expect(@reservation.trade).to eq(@trade)
  end

  it 'is not valid with a duplicate user_id, trade_id, and date' do
    @reservation.save
    expect(@reservation).to be_valid

    duplicate_reservation = Reservation.new(user_id: @user.id, trade_id: @trade.id, date: Date.today, city: @city)
    expect(duplicate_reservation).not_to be_valid
  end
end
