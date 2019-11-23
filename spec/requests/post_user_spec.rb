# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'post a user route', type: :request do
  before do
    post '/api/users', params: {
      user: { name: 'User Name',
              email: 'example@example.com',
              password: '1Pa$$w0rd',
              password_confirmation: '1Pa$$w0rd' }
    }
  end

  it 'returns status code 200 with valid params' do
    expect(response).to have_http_status(200)
  end

  it 'JSON body response contains expected token attribute' do
    json_response = JSON.parse(response.body)
    expect(json_response.keys).to match_array(['token'])
  end
end
