# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  direction  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :integer
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :reply
  belongs_to :comment
  attr_accessible :user_id, :post_id, :direction, :comment_id, :reply_id
end
