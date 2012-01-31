class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  authenticates_with_sorcery!
  acts_as_follower
  acts_as_followable


  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  before_create :set_username
  has_many :tweets

  def recent_tweets
    Tweet.where(:user_id => self.id)
  end

  def timeline
    current_user_as_well_as_following_users_id = [self.id]
    self.followings.map{|follow|  current_user_as_well_as_following_users_id << follow.followable_id}
    Tweet.where(:user_id => current_user_as_well_as_following_users_id).order('created_at desc').limit(30)
  end

  def follower_suggestion
    currently_following_user_ids = self.followings.map{|follow| follow.followable_id}
    self.where('id not in ?', currently_following_user_ids).order('random()').limit(4)
  end

  def last_tweet
    Tweet.where(:user_id => self.id).order('created_at desc').first
  end

  def tweets_count
    Tweet.where(:user_id => self.id).count
  end

  private
  def set_username
    self.username = self.email.split("@").first
  end

end