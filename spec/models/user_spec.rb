# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it 'created with valid attributes' do
    count = User.count
    new_user = User.create!(name: 'new user',
                            email: 'example@example.com',
                            password: '1Pa$$w0rd',
                            password_confirmation: '1Pa$$w0rd')
    expect(User.count).to equal(count + 1)
    expect(new_user.admin).to be_falsy
  end

  it 'name must be present' do
    user.name = ''
    expect(user.valid?).to be_falsy
  end

  it 'name must be < 33 characters long' do
    str = 'a' * 33
    user.name = str
    expect(user.valid?).to be_falsy
  end

  it 'name valid with standard characters' do
    names = ['Mr My Name', 'tony esquire esq', 'Breakfast Lunch Dinner', "tim o'leary", 'asha johnson-thompson']
    names.each do |n|
      user.name = n
      expect(user.valid?).to be_truthy
    end
  end

  it 'name invalid with non-standard characters' do
    names = ['toni&guy', "it's me!", '123', 'who?', '100%']
    names.each do |n|
      user.name = n
      expect(user.valid?).to be_falsy
    end
  end

  it 'password and password confirmation much match' do
    user.password_confirmation = '1Different$'
    expect(user.valid?).to be_falsy
  end

  it 'passwords have min length of 8' do
    password = 'N0t!ong'
    user.password = password
    user.password_confirmation = password
    expect(user.valid?).to be_falsy
  end

  it 'passwords have max length of 256' do
    password = '1P!' + 'a' * 256
    user.password = password
    user.password_confirmation = password
    expect(user.valid?).to be_falsy
  end

  it 'email must have valid format' do
    valid = ['firstname.lastname@domain.co.uk', 'me@me.com']
    valid.each do |v|
      user.email = v
      expect(user.valid?).to be_truthy
    end
  end

  it 'email with invalid formats rejected' do
    invalid = %w[me_at_me.com tony_dot_com @my_address]
    invalid.each do |v|
      user.email = v
      expect(user.valid?).to be_falsy
    end
  end

  it 'password must have specific format' do
    invalid = %w[mypassword MyPassword Password! passw0rd! 5password!]
    invalid.each do |v|
      user.password = v
      user.password_confirmation = v
      expect(user.valid?).to be_falsy
    end
  end

  it 'name invalid with non word characters' do
    invalid = %w[bonxo*%^$ <>%$^^name]
    invalid.each do |v|
      user.name = v
      expect(user.valid?).to be_falsy
    end
  end

  it 'name valid with word characters and space' do
    valid = ['Dr Jon Person', 'John Smith Esq']
    valid.each do |v|
      user.name = v
      expect(user.valid?).to be_truthy
    end
  end
end
