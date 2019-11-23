# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth
  def login
    @user = User.find_by(email: params[:authentication][:email])
    if @user&.authenticate(params[:authentication][:password])
      token = make_token(@user.id, @user.name, @user.admin)
      render json: { token: token },
             status: :ok
    else
      render json: { msg: 'unauthorized' }, status: :unauthorized
    end
  end

  # GET /auth
  def refresh
    token = make_token(@user.id, @user.name, @user.admin)
    render json: { token: token },
           status: :ok
  end

  private

  def login_params
    params.require(:authentication).permit(:email, :password)
  end
end
