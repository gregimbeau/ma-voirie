class Admin::ReportsController < ApplicationController
  before_action :check_if_admin

  def index
    @reports = Report.all.where(is_validate: nil)
  end

  def edit
    @report = Report.find(params[:id])
  end

  def show
    @report = Report.find(params[:id])
  end

  
end
