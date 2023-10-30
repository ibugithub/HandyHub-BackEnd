require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :request do
  describe 'POST /signup' do
    it 'creates a new user and returns a 200 status code' do
      post '/signup', params: { user: { name: 'john', email: 'test@example.com', password: 'password' } },
                      headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(200)

      json_response = JSON.parse(response.body)
      expect(json_response['status']['code']).to eq(200)
      expect(json_response['status']['message']).to eq('Signed up successfully.')
      expect(json_response['data']['email']).to eq('test@example.com')
    end

    it 'returns a 422 status code and error message when user creation fails' do
      post '/signup', params: { user: { name: '', email: '', password: '' } },
                      headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)
      expect(json_response['status']['code']).to eq(422)
      expect(json_response['status']['message']).to include("User couldn't be created successfully")
    end
  end
end
