require 'rails_helper'

RSpec.describe 'Trades', type: :request do
  let(:user) { create(:user) }
  describe 'GET /index' do
    it 'returns a list of trades' do
      user = create(:user, id: 1)
      sign_in user

      create_list(:trade, 5)

      get '/api/v1/trades'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)

      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(5)
    end
  end

  describe 'POST /api/v1/trades' do
    it 'creates a new trade' do
      sign_in user

      trade_attributes = {
        name: 'House Drilling',
        description: 'Description of the trade',
        image: 'image.jpg',
        location: 'Trade Location',
        price: '100.0',
        duration: '1 hour',
        trade_type: 'Type of Trade',
        user_id: user.id,
        removed: false
      }

      post '/api/v1/trades', params: { trade: trade_attributes }

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response).to be_a(Hash)
      expect(json_response['name']).to eq('House Drilling')
    end
  end

  describe 'GET /api/v1/trades/:id' do
    it 'returns a specific trade' do
      trade = create(:trade)
      user = create(:user, id: 1)
      sign_in user

      get "/api/v1/trades/#{trade.id}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)

      expect(json_response).to be_a(Hash)
      expect(json_response['id']).to eq(trade.id)
    end

    it 'returns a not found error when the trade does not exist' do
      user = create(:user, id: 1)
      sign_in user
      get '/api/v1/reservations/999'
      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      expect(json_response).to be_a(Hash)
      expect(json_response['message']).to eq('No reservations found for the user and trades.')
    end
  end

  describe 'DELETE /api/v1/trades/:id' do
    it 'deletes a specific trade' do
      trade = create(:trade)
      sign_in user

      delete "/api/v1/trades/#{trade.id}"

      expect(response).to have_http_status(:no_content)

      deleted_trade = Trade.find_by(id: trade.id)

      expect(deleted_trade).to be_nil
    end

    it 'returns a not found error when the trade does not exist' do
      expect do
        user = create(:user, id: 1)
        sign_in user
        delete '/api/v1/trades/999'
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
