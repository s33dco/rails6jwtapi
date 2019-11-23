# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user, except: %i[create index]
  before_action :admin_user?, only: %i[index destroy]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    render json: @user, serializer: UserSerializer, status: 200
  end

  def create
    @user = User.new(user_params)
    @user.admin = false
    if @user.save
      token = make_token(@user.id, @user.name, @user.admin)
      render json: { token: token }, status: 200
    else
      render json: { msg: @user.errors.full_messages },
             status: 400
    end
  end

  def update
    if @user.update(user_params)

    else
      render json: { msg: @user.errors.full_messages },
             status: 400
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
