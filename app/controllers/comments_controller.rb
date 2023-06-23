class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @report = Report.find(params[:report_id])
    @comment = @report.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @report
    else
      redirect_to @report, alert: 'Erreur lors de la création du commentaire'
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
