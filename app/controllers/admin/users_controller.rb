class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params['id'])
    @user.delete
    flash[:alert] = "Le compte a bien été supprimé !"
    redirect_to root_path
  end

end
