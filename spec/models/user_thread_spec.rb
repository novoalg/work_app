# == Schema Information
#
# Table name: user_threads
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe UserThread do
end
