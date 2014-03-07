class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :post_id
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :post_it, :presence => true
  belongs_to :post
end
