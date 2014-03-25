class VoteRelationship < ActiveRecord::Base
   attr_accessible :upvoted_post_id, :downvoted_post_id

    # upvote
   belongs_to :upvoter, :class_name => "User"
   belongs_to :upvoted, :class_name => "Post"
   #validates :upvoter_id, :present => true
   #validates :upvoted_post_id, :present => true


    # downvote
   belongs_to :downvoter, :class_name => "User"
   belongs_to :downvoted, :class_name => "Post"
   #validates :downvoter_id, :present => true
   #validates :downvoted_post_id, :present => true

end
