class UserSessionsController < ApplicationController
  before_filter :check_if_logged_in, :except => [:destroy]
  skip_before_filter :require_login, :except => [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:email],params[:password],params[:remember])
        format.html { redirect_back_or_to(:tweets, :notice => 'Login successfull.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    logout
    redirect_to(root_url, :notice => 'Logged out!')
  end

end
