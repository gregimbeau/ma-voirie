class RepliesController < ApplicationController
  before_action :authenticate_user!
  
  def new

  end

  def create
    @reply = Reply.new(user_id: current_user.id, comment_id: params[:comment_id], content: params[:content])
    
    if @reply.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update

  end

  def destroy

  end
end
