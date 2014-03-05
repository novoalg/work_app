# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  username       :string(255)
#  email          :string(255)
#  remember_token :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin          :boolean
#

class User < ActiveRecord::Base
  attr_accessible :email, :username 
  validates :username, :uniqueness => true, :presence => true, :length => { :minimum => 3, :maximum => 20 }
  has_many :subreddits, :dependent => :destroy
  #before_save { |user| user.email = email.downcase }
  #before_save :create_remember_token
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, :uniqueness => true, :presence => true, :format => { :with => VALID_EMAIL_REGEX }
  extend FriendlyId
  friendly_id :username
  def to_param
    "#{username}".parameterize
  end

  private 

   def create_remember_token
     self.remember_token = SecureRandom.base64.tr("+/", "-_")
   end
end
