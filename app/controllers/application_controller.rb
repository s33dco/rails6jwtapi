# frozen_string_literal: true

class ApplicationController < ActionController::API
  def not_found
    render json: { msg: 'not_found!' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { msg: e.message }, status: :not_found
    rescue JWT::ExpiredSignature => e
      render json: { msg: e.message }, status: :forbidden
    rescue JWT::InvalidIssuerError => e
      render json: { msg: e.message }, status: :forbidden
    rescue JWT::DecodeError => e
      render json: { msg: "You're going to have to sign in, #{e.message} ." },
             status: :forbidden
    end
  end

  def make_token(id, name, admin)
    payload = { user_id: id,
                name: name,
                admin: admin }
    JsonWebToken.encode(payload)
  end

  def set_user
    @user = @current_user
  end

  def admim_user?
    @current_user.admin
  end
end
