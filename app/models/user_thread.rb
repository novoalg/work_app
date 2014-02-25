class UserThread < ActiveRecord::Base
  attr_accessible :content, :user_id
end
