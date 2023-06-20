class RepliesController < ApplicationController
  before_action :authenticate_user!
  
  def new

  end

  def create
    @reply = Reply.new(user_id: current_user.id, comment_id: params[:comment_id], nickname: User.find(id: current_user.id).nickname, content: params[:content])

    puts "#"*1000
    puts current_user.id
    puts params[:comment_id]
    puts params[:nickname]
    puts params[:content]
    
    if @reply.save
      puts "#"*1000
      puts "OKK"
    else
      puts "#"*1000
      errors = @reply.errors.full_messages
      puts errors
    end
  end

  def update

  end

  def destroy

  end
end
