class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: [:new, :create]
  before_action :check_if_admin_or_creator, only: [:show]

  def index
    @reports = Report.where(is_validate:true)
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    respond_to do |format|
      if @report.images.attached? && @report.save
        format.html { redirect_to report_url(@report), notice: "Le signalement a correctement été créé." }
        format.json { render :show, status: :created, location: @report }
      elsif @report&.images.count == 0
        flash[:alert] = "Vous devez charger au moins une photo pour valider le signalement."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      else
        flash[:alert] = @report.errors.full_messages.join(', ')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: "Le signalement a correctement été mise à jour" }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report.comments.each(&destroy)
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Le signalement a correctement été supprimé." }
      format.json { head :no_content }
    end
  end
  
  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content, :is_validate, :user_id, :status_id, :address, images: [])
  end

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter pour créer un signalement."
      redirect_to new_user_session_path
    end
  end
  
end