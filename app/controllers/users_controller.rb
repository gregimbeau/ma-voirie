class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by(id: params[:id])

  end

  def edit
    @user = User.find(params[:id])
    @can_change_password = can_change_password?
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def check_user
    @user = User.find_by(id: params[:id])
    if @user&.id != current_user&.id
      redirect_to root_path
    end
  end
  
end


private

def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :description)
end

def correct_user
  @user = User.find(params[:id])
  redirect_to(root_url) unless @user == current_user
end