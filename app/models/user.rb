# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :length => { :maximum => 50 }
  validates :username, :uniqueness => true, :presence => true, :length => { :minimum => 3, :maximum => 20 }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :password_confirmation, :presence => true
  has_secure_password
  validates_confirmation_of :password
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :uniqueness => true, :presence => true, :format => { :with => VALID_EMAIL_REGEX }

  private 

   def create_remember_token
     self.remember_token = SecureRandom.base64.tr("+/", "-_")
   end
end
