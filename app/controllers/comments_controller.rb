class CommentsController < ApplicationController
    def create
        @comment = Comment.create(params[:comment])
        post = Post.find_by_id(@comment.post_id)
        @comment.karma = 0
        @comment.user_id = current_user.id
        @comment.post_id = post.id
        #@comments = Comment.where(:post_id => @post.id)
        sub_id = Subreddit.find_by_subname(post.subname)
        @comment.save
        redirect_to subreddit_post_path(Subreddit.find_by_subname(post.subname).id, post.id)
    end

    def reply
        @comment = Comment.find_by_id(params[:comment_id])
        @reply = Reply.new
        respond_to do |format| 
            format.html { redirect_to subreddit_post_path(Subreddit.find_by_subname(@post.subname).id, @post.id)}
            format.js
        end


    end

    def new
        @comment = Comment.new(params[:id])
        #@post = Post.find(params[:post_id])
        #@subreddit = Subreddit.find_by_subname(@post.subname)
    end 

    def show
        @comment = Comment.find_by_id(params[:id])
        @replies = Reply.where(:comment_id => @comment.id)
        @post = Post.find_by_id(@comment.post_id)
        #@vote = current_user.build_vote
    end

    def destroy
    end

    def vote
        @user = current_user
        @user_comment = Comment.find(params[:comment_id])
        post_id = @user_comment.post_id
        @post = Post.find(post_id)
        @direction = params[:direction]
        @vote_has_been_destroyed = false
        if @user.has_comment_voted?(@user_comment)
            
            @vote = @user.votes.where("comment_id = ?", @user_comment.id).first
            logger.info "********************************VOTE   #{@vote.inspect}   ********************"
            dir = @vote.direction
            #logger.info "********************************DIR   #{dir}   ********************"
            if dir == "up" && @direction == "up"
                @vote.destroy
                @vote_has_been_destroyed = true
                @user_comment.decrease_karma
            elsif dir == "down" && @direction == "down"
                @vote.destroy
                @vote_has_been_destroyed = true
                @user_comment.increase_karma
            elsif dir == "down" && @direction == "up"
                @vote.direction = @direction
                @user_comment.increase_karma
                @user_comment.increase_karma
            elsif dir == "up" && @direction == "down"
                @vote.direction = @direction
                @user_comment.decrease_karma
                @user_comment.decrease_karma
            end
            @vote.save!
            logger.info "********************************VOTE   #{@vote_has_been_destroyed}   ********************"
            logger.info "********************************VOTE   #{@direction}   ********************"

        else
            @user.build_vote(:user_id => @user.id, :comment_id => @user_comment.id, :direction => @direction).save!
            if  @direction == "up"
                @user_comment.increase_karma
            end
            if  @direction == "down"
                @user_comment.decrease_karma
            end
        end
       
        respond_to do |format| 
            format.html { redirect_to subreddit_post_path(Subreddit.find_by_subname(@post.subname).id, @post.id)}
            format.js
        end
    end

end
