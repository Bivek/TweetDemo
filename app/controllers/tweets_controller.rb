class TweetsController < ApplicationController

  def index
    @tweets = current_user.timeline
    @new_tweet = current_user.tweets.new
  end

end
