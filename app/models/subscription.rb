class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :subreddit_id
  belongs_to :user
  belongs_to :subreddit
end
