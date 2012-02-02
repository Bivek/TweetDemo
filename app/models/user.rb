class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  authenticates_with_sorcery!
  acts_as_follower
  acts_as_followable


  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  
  #set username from email address
  before_save :set_username
  
  has_many :tweets
  
  has_attached_file :avatar, 
    :url => "/assets/images/user/:id/:style/:basename.:extension",
    :styles => { 
      :large => "128x128#", 
      :medium => "48x48#", 
      :thumb => "24x24#"
    }
      
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/jpg'] 
  validates_attachment_size :avatar, :less_than => 3.megabytes
  

  def recent_tweets
    Tweet.where(:user_id => self.id)
  end

  def timeline
    user_as_well_as_following_users_id = [self.id]
    self.followings.map{|follow|  user_as_well_as_following_users_id << follow.followable_id}
    Tweet.where(:user_id => user_as_well_as_following_users_id).order('created_at desc').limit(30).includes(:user)
  end

  def follower_suggestion
    currently_following_user_ids = self.following_users.map{|following| following.id}
    user_ids_to_exclude = [self.id] + currently_following_user_ids
    User.where('id not in (?)', user_ids_to_exclude).order('random()').limit(4)
  end

  def last_tweet
    Tweet.where(:user_id => self.id).order('created_at desc').first
  end

  def tweets_count
    Tweet.where(:user_id => self.id).count
  end
  
  def update_only_allowed_values(params)
    self.username = params[:username]
    self.avatar = params[:avatar]
    self.save
  end

  private
  def set_username
    self.username = self.email.split("@").first if self.username.blank?
  end

end