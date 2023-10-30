require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/v1/users' do
    context 'when the user is authenticated' do
      let(:user) { create(:user) }

      before do
        sign_in user
        get '/api/v1/users'
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'returns user attributes in JSON' do
        json_response = JSON.parse(response.body)
        expect(json_response).to include('name', 'email', 'role', 'created_at', 'id')
      end
    end
  end
end
