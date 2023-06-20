class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @report = Report.find(params[:report_id])
    @comment = @report.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @report, notice: 'Commentaire créé'
    else
      # Handle the case when comment creation fails
      # You may render the form again with error messages
    end
  end

  # Other actions like edit, update, destroy, etc.
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
