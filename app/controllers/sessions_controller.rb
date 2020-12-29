# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :set_user
  def new; end

  def create
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/contests', notice: 'Logged in!'
    else
      flash.now[:alert] = 'Invalid credentials'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: 'Logged out!'
  end

  private

  def set_user
    @user = User.find_by_email(params[:email])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
