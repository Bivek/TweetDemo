class UsersController < ApplicationController
  before_filter :check_if_logged_in, :only => ['new', 'create']
  before_filter :require_login, :except => ['new', 'create']

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to(tweets_url, :notice => 'Registration successfull.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    begin
      @user = User.find(params[:id])
      redirect_to :tweets and return if current_user == @user
      @tweets = @user.timeline
      @follow_unfollow_show_text = current_user.following?(@user) ? 'Unfollow' : 'Follow'
    rescue
      redirect_to :tweets and return
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    if current_user.update_only_allowed_values(params[:user])
      redirect_to :tweets and return
    else
      render 'edit' and return
    end
  end
  
end
