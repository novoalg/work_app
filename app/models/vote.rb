class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :comment
  attr_accessible :user_id, :post_id, :direction, :comment_id
end
