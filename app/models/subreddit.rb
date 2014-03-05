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
#

class Subreddit < ActiveRecord::Base
  attr_accessible :subname, :title, :description, :user_id
  belongs_to :user
  validates :user_id, :presence => true
  VALID_SUBNAME_REGEX = /^([a-z]{3,}|[a-z]{1,}[0-9]{1,}|[a-z]{1,}[0-9]{1,}[a-z]{1,}|[\w]{3,}[a-z]|[a-z]+[\w]+[0-9]+|[a-z]{3,}[0-9])$/
  validates :subname, :presence => true, :uniqueness => true, :length => { :maximum => 15 }, :format => { :with => VALID_SUBNAME_REGEX }
  validates :title, :presence => true
  validates :description, :presence => true
  def to_param
    "#{subname}".parameterize
  end


end
