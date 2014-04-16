# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string(255)
#  karma      :integer          default(0)
#  post_id    :integer
#

class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  has_many :votes
  attr_accessible :user_id, :comment_id, :content, :karma, :post_id


  def increase_karma()
    self.karma += 1
    self.save!
  end

  def decrease_karma()
    self.karma -= 1
    self.save!
  end
end

