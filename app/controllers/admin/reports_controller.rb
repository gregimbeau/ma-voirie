class Admin::ReportsController < ApplicationController
  before_action :check_if_admin

  def index
    @reports = Report.all.where(is_validate: nil)
    @validated = Report.all.where(status_id: 2)
    @accepted = Report.all.where(status_id: 3)
    @in_progress = Report.all.where(status_id: 4)
    @resolved = Report.all.where(status_id: 5)
  end

  def edit
    @report = Report.find(params[:id])
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if params['report'] == "true"
      @report.update!(is_validate: true, status_id: 2)
      flash[:notice] = "Le signalement a été validé !"
      redirect_to admin_reports_path
    elsif params['report'] == "false"
      @report.update!(is_validate:false)
      flash[:notice] = "Le signalement a été refusé !"
      redirect_to admin_reports_path
    elsif
      @report.update!(status_id:3)
      flash[:notice] = "Le signalement a été accepté !"
      redirect_to admin_reports_path
    elsif
      @report.update!(status_id:4)
      flash[:notice] = "Les travaux sont en cours !"
      redirect_to admin_reports_path
    else
      @report.update!(status_id:5)
      flash[:notice] = "Les travaux sont terminés !"
      redirect_to admin_reports_path
    end
  end

end