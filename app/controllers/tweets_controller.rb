class TweetsController < ApplicationController

  before_filter :require_login

  def index
    @tweets = current_user.timeline
    @new_tweet = current_user.tweets.new
  end

end
