class Admin::ReportsController < ApplicationController
  before_action :check_if_admin

  def index
    @reports = Report.where(is_validate: nil)
    @validated = Report.where(status: 1)
    @accepted = Report.where(status: 2)
    @in_progress = Report.where(status: 3)
    @resolved = Report.where(status: 4)
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
      @report.update!(is_validate: true, status: 1)
      flash[:notice] = "Le signalement a été validé !"
      redirect_to admin_reports_path
    elsif params['report'] == "false"
      @report.update!(is_validate:false)
      flash[:notice] = "Le signalement a été refusé !"
      redirect_to admin_reports_path
    elsif params['report'] == "accepted"
      @report.update!(status: 2)
      flash[:notice] = "Le signalement a été accepté !"
      redirect_to admin_reports_path
    elsif params['report'] == "in progress"
      @report.update!(status: 3)
      flash[:notice] = "Les travaux sont en cours !"
      redirect_to admin_reports_path
    else params['report'] == "resolved"
      @report.update!(status: 4)
      flash[:notice] = "Les travaux sont terminés !"
      redirect_to admin_reports_path
    end
  end

  def destroy
    @report = Report.find(params['id'])
    @report.destroy
    flash[:notice] = "Le signalement a bien été supprimé !"
    redirect_to admin_reports_path
  end

end