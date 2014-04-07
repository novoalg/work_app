class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  attr_accessible :user_id, :comment_id
end

