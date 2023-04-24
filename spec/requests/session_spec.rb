# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /sign-in' do
    it 'returns http success' do
      get '/sign-in'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /sign-in' do
    let(:user) { create(:user) }
    it 'can sign a user in' do
      post '/sign-in', params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /sign-out' do
    let(:user) { create(:user) }
    it 'can sign out a user' do
      post '/sign-in', params: { email: user.email, password: user.password }
      delete '/sign-out'
      expect(response).to have_http_status(:found)
    end
  end
end
