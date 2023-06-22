class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params['id'])
    if !User.find_by(nickname: ENV['DELETE_USER_NICKNAME'], email: ENV['DELETE_USER_EMAIL'])
      @delete_user = User.create(nickname: ENV['DELETE_USER_NICKNAME'], email: ENV['DELETE_USER_EMAIL'], password: ENV['DELETE_USER_PASSWORD'], password_confirmation: ENV['DELETE_USER_PASSWORD'])
    else
      @delete_user = User.find_by(nickname: ENV['DELETE_USER_NICKNAME'], email: ENV['DELETE_USER_EMAIL'])
    end
    if @user.reports.count == 0
      @user.destroy
      flash[:alert] = "Le compte a bien été supprimé !"
      redirect_to admin_users_path
    else
      @user.reports.each do |report|
        report.update(user_id: @delete_user.id)
      end
      @user.destroy
      flash[:alert] = "Le compte a bien été supprimé !"
      redirect_to admin_users_path
    end
  end

end
