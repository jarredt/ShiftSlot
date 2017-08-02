class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    flash[:notice] = 'User updated'
    redirect_to edit_user_path(@user.id)
  end
end


private

def user_params
  params.require(:user).permit(:admin)
end
