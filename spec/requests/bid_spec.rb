# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bids', type: :request do
  describe 'POST /lot/:id/bid' do
    before :all do
      user = create(:user)
      login_user(user, 'password', users_sign_in_path)
    end

    let(:lot) { create(:lot) }
    it 'returns http success' do
      post "/lots/#{lot.id}/bid", params: { lot: { amount: 50 } }
      expect(response).to be_successful
    end

    it 'creates a bid for the logged in user' do
      expect do
        post "/lots/#{lot.id}/bid", params: { lot: { amount: 99_999 } }
      end.to change(Bid, :count).by(1)
    end
  end
end
