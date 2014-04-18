# == Schema Information
#
# Table name: subreddits
#
#  id          :integer          not null, primary key
#  subname     :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string(255)
#  description :string(255)
#  user_count  :integer          default(0)
#

class Subreddit < ActiveRecord::Base
  attr_accessible :subname, :title, :description, :user_id, :user_count
  belongs_to :user
  has_many :posts, :foreign_key => "subname"
  has_many :subscriptions
  #validates :user_id, :presence => true
  default_scope :order => 'LOWER(subname) ASC' 
  VALID_SUBNAME_REGEX = /^([a-zA-Z]{3,}|[a-zA-Z]{1,}[0-9]{1,}|[a-zA-Z]{1,}[0-9]{1,}[a-zA-Z]{1,}|[\w]{3,}[a-zA-Z]|[a-zA-Z]+[\w]+[0-9]+|[a-z]{3,}[0-9])$/
  validates :subname, :presence => true, :uniqueness => true, :length => { :maximum => 30 }, :format => { :with => VALID_SUBNAME_REGEX }
  validates :title, :presence => true
  validates :description, :presence => true
  def to_param
    "#{subname}".parameterize
  end

  def increase_user_count()
    self.user_count += 1
    self.save!
  end

  def decrease_user_count()
    self.user_count -= 1
    self.save
  end


end
