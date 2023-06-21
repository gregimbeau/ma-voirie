class Admin::UsersController < ApplicationController
  before_action :check_if_admin
  require 'faker'

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params['id'])
    @user.nickname = "Compte supprimé"
    @user.email = "#{Faker::Lorem.characters(number: 15, min_alpha: 15)}@yopmail.com"
    @password = Faker::Lorem.characters(number: 15)
    @user.update(password: @password, password_confirmation: @password)
    flash[:alert] = "Le compte a bien été supprimé !"
    redirect_to admin_users_path
  end

end
