# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_REGEX = /\A(?=.{8,})
                      (?=.*\d)
                      (?=.*[a-z])
                      (?=.*[A-Z])
                      (?=.*[[:^alnum:]])
                      /x.freeze

  NAME_REGEX = /\A[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*\z/.freeze

  has_secure_password

  validates :name,      presence: true,
                        length: { maximum: 32, message: 'maximum 32 charaters!' },
                        format: {
                          with: NAME_REGEX,
                          message: 'contains invalid charater!'
                        }

  validates :email,     presence: true,
                        uniqueness: {
                          case_sensitive: false,
                          message: 'already in use!'
                        },
                        format: {
                          with: URI::MailTo::EMAIL_REGEXP,
                          message: 'is invalid'
                        }
  validates :password,  length: { minimum: 8, maximum: 256 },
                        format: {
                          with: PASSWORD_REGEX,
                          message: 'requires atleast one, upper, lower, number & symbol character'
                        },
                        if: -> { new_record? || !password.nil? }
end
