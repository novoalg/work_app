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

require 'spec_helper'

describe Subreddit do
  pending "add some examples to (or delete) #{__FILE__}"
end
