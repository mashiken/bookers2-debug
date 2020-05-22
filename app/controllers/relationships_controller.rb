class RelationshipsController < ApplicationController
   before_action :authenticate_user!
   before_action :baria_user, only: [:edit,:update]

  def create
  	current_user.follow(params[:id])
  	redirect_to users_path
  end

  def follows_user_show
    @user = User.find(params[:id])
  end

  def follower_user_show
    @user = User.find(params[:id])
  end

  def destroy
  	current_user.unfollow(params[:id])
  	redirect_to users_path
  end

  private

  def baria_user
    if params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
