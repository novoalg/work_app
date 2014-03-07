class CommentsController < ApplicationController
    
    def create
        @comment = Comment.create(params[:comment])
        if @comment.save
            redirect_to subreddit_post_path(Subreddit.find_by_subname(params[:post][:subname]),
Post.find_by_id(:post_id))
        else
            render 'new'
        end
    end

    def destroy
    end
end
