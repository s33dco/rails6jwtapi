# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ISSUER = 's33dco'

  def self.encode(payload)
    payload[:exp] = Time.now.to_i + 15 * 60
    payload[:iss] = ISSUER
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, iss: ISSUER, verify_iss: true, algorithm: 'HS256')
    decoded[0].transform_keys!(&:to_sym)
  end
end
