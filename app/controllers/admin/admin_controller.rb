class Admin::AdminController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.all
    @reports = Report.where(is_validate: nil)
  end
end
