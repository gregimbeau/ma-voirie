class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_current_user

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params, context: :user_update)
      redirect_to @user, notice: 'Profil mis à jour avec succès!'
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
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
  
  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter pour voir votre profil"
      redirect_to new_user_session_path
    end
  end
  
  def authenticate_current_user
    unless current_user == User.find(params['id'])
      flash[:alert] = "Vous ne pouvez accéder qu'à votre profil"
      redirect_to root_path
    end
  end
end
