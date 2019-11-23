# frozen_string_literal: true

def digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

FactoryBot.define do
  factory :user do
    name { 'person example' }
    email { 'example@example.com' }
    password_digest { digest(SecureRandom.urlsafe_base64) }
  end
end
