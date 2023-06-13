class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @can_change_password = can_change_password?
  end

  def update
    if @user.update(user_params, context: :user_update)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  

end
