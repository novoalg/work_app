class RepliesController < ApplicationController
    
    def new
        @reply = Reply.new(params[:id])
    end

    def create

        @reply = Reply.create(params[:reply])
        @reply.karma = 0
        post = Post.find_by_id(Comment.find(@reply.comment_id).post_id)
        @reply.save
        redirect_to subreddit_post_path(Subreddit.find_by_subname(post.subname).id, post.id)
    end

    def show
        @reply = Reply.find(params[:id])
        @reply.karma = @reply.votes.where(:direction => "up", :reply_id => @reply.id).count - @reply.votes.where(:direction => "down", :reply_id => @reply.id).count
        @post = Post.find(Comment.find(@reply.comment_id).post_id)
    end
    def vote
        @user = current_user
        @user_reply = Reply.find(params[:reply_id])
        sub = Subreddit.find_by_subname(Post.find(Comment.find(@user_reply.comment_id).post_id).subname)
        post = Post.find(Comment.find(@user_reply.comment_id).post_id)
        @direction = params[:direction]
        @vote_has_been_destroyed = false
        logger.info "********************************DIR   #{@user_reply.inspect}   ********************"
        if @user.has_reply_voted?(@user_reply)
            
            vote = @user_reply.votes.where("reply_id = ?", @user_reply.id).first
            logger.info "********************************VOTE   #{vote.inspect}   ********************"
            dir = vote.direction
            if dir == "up" && @direction == "up"
                vote.destroy
                @vote_has_been_destroyed = true
                @user_reply.decrease_karma
            elsif dir == "down" && @direction == "down"
                vote.destroy
                @vote_has_been_destroyed = true
                @user_reply.increase_karma
            elsif dir == "down" && @direction == "up"
                vote.direction = @direction
                @user_reply.increase_karma
                @user_reply.increase_karma
            elsif dir == "up" && @direction == "down"
                vote.direction = @direction
                @user_reply.decrease_karma
                @user_reply.decrease_karma
            end
            vote.save!
        else
            Vote.create(:user_id => @user.id, :reply_id => @user_reply.id, :direction => @direction)
            if  @direction == "up"
                @user_reply.increase_karma
            end
            if  @direction == "down"
                @user_reply.decrease_karma
            end
        end
       
        respond_to do |format| 
            format.html { redirect_to subreddit_post_path(sub)}
            format.js
        end
    end

end
