# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name,      presence: true,
                        length: { maximum: 32, message: 'maximum 32 charaters!' }
  # format: {
  #   with: /A(([\w-,'&.()]+)(\s?))+z/,
  #   messages: 'Name contains invalid charater!'
  # }

  validates :email,     presence: true,
                        uniqueness: { case_sensitive: false, message: 'already in use!' },
                        format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,  length: { minimum: 8 }
  # format: {
  #   with: /A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@£$!%*?&])[A-Za-z\d@£$!%*?&]{8,}z/,
  #   message: 'password requires atleast one uppercase & lowercase letter, one number & one special character (@£$!%*?&), between 8 and 50 characters long'
  # },
  # if: -> { new_record? || !password.nil? }
end
