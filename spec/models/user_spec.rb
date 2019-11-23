# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'created with valid attributes' do
    count = User.count
    user = User.create!(name: 'new user',
                        email: 'example@example.com',
                        password: '1Pa$$w0rd',
                        password_confirmation: '1Pa$$w0rd')
    expect(User.count).to equal(count + 1)
    expect(user.admin).to be_falsy
  end
end
