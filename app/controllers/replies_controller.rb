class RepliesController < ApplicationController
  before_action :authenticate_user!
  
  def new

  end

  def create
    @reply = Reply.new(user_id: current_user.id, comment_id: params[:comment_id], content: params[:content])
    
    if @reply.save
      redirect_to @reply, notice: 'Commentaire soumis.'
    else
      redirect_to @reply, alert: 'Erreur lors de la publication de votre commentaire'
    end
  end

  def update

  end

  def destroy

  end
end
