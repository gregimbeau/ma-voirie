class ReportLikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    @like = ReportLike.new(user_id: current_user.id, report_id: params[:report_id])
    @report = Report.find_by(id: params[:report_id])
    if @like.save
      redirect_to @report
    end
  end

  def destroy
    @like = ReportLike.find_by(user_id: current_user.id, report_id: params[:report_id])
    @report = Report.find_by(id: params[:report_id])
    if @like.destroy
      redirect_to @report
    end
  end

end
