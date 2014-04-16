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

require 'spec_helper'

describe Vote do
  pending "add some examples to (or delete) #{__FILE__}"
end
