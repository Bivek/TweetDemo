class FollowUnfollowController < ApplicationController
  before_filter :require_login
  
  def follow
    if request.xhr?
      begin
        @user_to_follow = User.find(params[:id])
        unless current_user == @user_to_follow && current_user.following?(@user_to_follow)
          current_user.follow(@user_to_follow)
        end
      rescue
         render :nothing => true and return
       end
    else
      redirect_to :back and return
    end
  end
  
  def unfollow
    if request.xhr?
      begin
        @user_to_unfollow = User.find(params[:id])
        if current_user.following?(@user_to_unfollow)
          current_user.stop_following(@user_to_unfollow)
        end
      rescue
        render :nothing => true and return
      end
    else
      redirect_to :back and return
    end
  end

end
