# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_parties = UserParty.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if User.find_by(email: params[:user][:email]) != nil
      flash[:notice] = 'User Not Created: Email Taken.'
      redirect_to '/register'
    elsif params[:password].present? && params[:password_confirmation].present?
      if params[:password] != params[:password_confirmation]
        flash[:notice] = 'Passwords must match'
        redirect_to '/register'
      end
    elsif user.save
      redirect_to user_path(user.id)
    else
      flash[:notice] = 'User Not Created: Required info missing.'
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(params[:user_id])
  end

  def login_form
    render '/users/login_form'
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = 'Password and Email do not match our records.'
      redirect_to '/users/login_form'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
