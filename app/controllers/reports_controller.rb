class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: [:new, :create]

  # GET /reports or /reports.json
  def index
    @reports = Report.where(is_validate:true)
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    puts params
    @report = Report.new(report_params)
  
    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: "Le signalement a correctement été créé." }
        format.json { render :show, status: :created, location: @report }
      else
        flash[:alert] = @report.errors.full_messages.join(', ')
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /reports/1 or /reports/1.json
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

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Le signalement a correctement été supprimé." }
      format.json { head :no_content }
    end
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.purge_later
    redirect_back(fallback_location: request.referer)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :content, :is_validate, :user_id, :status_id, :address, images: [])
    end
    
end

def authenticate_user
  unless current_user
    flash[:alert] = "Merci de vous connecter pour créer un signalement."
    redirect_to new_user_session_path
  end

  
end