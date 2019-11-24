# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "exeample#{n}@example.com"
  end

  sequence :name do |_n|
    'person example'
  end

  factory :user do
    name
    email
    password { '1Pa$$w0rd' }
    password_confirmation { '1Pa$$w0rd' }
  end
end
