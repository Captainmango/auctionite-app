# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /registration' do
    it 'returns a view when get is called' do
      get '/registration'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /registration' do
    let(:user_attrs) { build(:user) }
    it 'can successfully create a user' do
      post '/registration', params: { user: { email: user_attrs.email, password: user_attrs.password } }
      expect(response).to have_http_status(:found)
    end

    it 'can validate presence of email' do
      post '/registration', params: { user: { email: '', password: user_attrs.password } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'can validate presence of password' do
      post '/registration', params: { user: { email: user_attrs.email, password: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'can validate length of password' do
      post '/registration', params: { user: { email: user_attrs.email, password: '12345' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
