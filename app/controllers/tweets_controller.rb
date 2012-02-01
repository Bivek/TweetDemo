class TweetsController < ApplicationController

  before_filter :require_login

  def index
    @tweets = current_user.timeline
    @new_tweet = current_user.tweets.new
  end
  
  def create
    current_user.tweets.create(params[:tweet])
    redirect_to :tweets and return
  end

end
