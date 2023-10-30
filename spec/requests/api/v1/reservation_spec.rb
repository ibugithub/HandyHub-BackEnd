require 'rails_helper'

RSpec.describe 'Reservation API', type: :request do
  describe 'GET /reservations' do
    it 'returns a list of user reservations with associated trades' do
      user = create(:user, id: 1)
      reservation1 = create(:reservation, user:)
      create(:reservation, user:)
      sign_in user
      get '/api/v1/reservations'
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(2)
      expect(json_response[0]['user_id']).to eq(user.id)

      expect(json_response[0]['trade']).to be_a(Hash)
      expect(json_response[0]['trade']['name']).to eq(reservation1.trade.name)
    end
  end

  describe 'POST /api/v1/reservations' do
    context 'with valid parameters' do
      let(:user) { create(:user) }
      let(:trade) { create(:trade) }
      let(:valid_attributes) do
        {
          trade_id: trade.id,
          date: '2023-10-01',
          city: 'city'
        }
      end

      it 'creates a new reservation' do
        sign_in user
        create(:user, id: 1)
        post '/api/v1/reservations', params: valid_attributes

        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')

        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Trade reserved successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          trade_id: 5,
          date: '2023-10-01'
        }
      end

      it 'does not create a reservation' do
        user = create(:user, id: 1)
        trade = create(:trade, id: 5)
        create(:reservation, user:, trade:, date: '2023-10-01')
        sign_in user
        post '/api/v1/reservations', params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Reservation failed')
        expect(json_response['errors']).not_to be_empty
      end
    end
  end

  describe 'GET /api/v1/reservations/:id' do
    it 'returns a single reservation with associated trade' do
      user = create(:user, id: 1)
      trade = create(:trade)
      reservation = create(:reservation, user:, trade:)
      sign_in user
      get "/api/v1/reservations/#{reservation.id}"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.first).to be_a(Hash)
      expect(json_response[0]['user_id']).to eq(user.id)
      expect(json_response[0]['trade']).to be_a(Hash)
      expect(json_response[0]['trade']['name']).to eq(trade.name)
    end

    it 'returns a not found message if reservation is not found' do
      user = create(:user, id: 1)
      sign_in user
      get '/api/v1/reservations/999'
      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      expect(json_response).to be_a(Hash)
      expect(json_response['message']).to eq('No reservations found for the user and trades.')
    end
  end

  describe 'DELETE /api/v1/reservations/:id' do
    it 'deletes a reservation' do
      reservation = create(:reservation)
      user = create(:user, id: 1)
      sign_in user
      delete "/api/v1/reservations/#{reservation.id}"

      expect(response).to have_http_status(:ok)

      expect { reservation.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error for a non-existent reservation' do
      expect do
        user = create(:user, id: 1)
        sign_in user
        delete '/api/v1/reservations/999'
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
