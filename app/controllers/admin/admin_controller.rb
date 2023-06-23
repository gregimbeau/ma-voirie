class Admin::AdminController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.all
    @reports = Report.where(is_validate: nil)
    @delete_user = User.find_by(nickname: ENV['DELETE_USER_NICKNAME'], email: ENV['DELETE_USER_EMAIL'])
  end

end
