class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def check_if_logged_in
    redirect_to :tweets and return if current_user
  end
end
