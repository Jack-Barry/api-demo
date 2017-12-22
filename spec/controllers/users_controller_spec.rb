require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user)    { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }

  let(:valid_attributes) do
    attributes_for(:user)
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end

      it "returns the example object (except for password)" do
        new_user      = User.find_by(username: valid_attributes[:username])
        new_user_json = json['user']

        expect(new_user_json['password']).to eq(nil)
        expect(new_user_json['password_digest']).to eq(nil)
        expect(new_user_json['auth_token']).to eq(nil)
        expect(new_user_json['id']).to eq(new_user.id)
        expect(new_user_json['created_at']).not_to be_nil
        expect(new_user_json['updated_at']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it "returns a hash of errors" do
        expect(json['errors']).to include("password" => [ "can't be blank" ])
      end
    end
  end
end
