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
    @user.nickname = "Compte supprimé"
    @user.email = "#{Faker::Lorem.characters(number: 15, min_alpha: 15)}@yopmail.com"
    @password = Faker::Lorem.characters(number: 15)
    @user.update(password: @password, password_confirmation: @password)
    flash[:alert] = "Le compte a bien été supprimé !"
    User.find(session[:user_id]).destroy      
    session[:user_id] = nil 
    redirect_to admin_users_path
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
