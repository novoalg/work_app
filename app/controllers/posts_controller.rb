class PostsController < ApplicationController

    def new
      @post = Post.new(params[:subreddit_id])
    end

    def create 
       @post = Post.create(params[:post]) 

       sub = Subreddit.find_by_subname(params[:post][:subreddit_id])
       unless sub.nil?
           if @post.save
                flash[:success] = "Your post has been created!"
                redirect_to subreddit_post_path(params[:post][:subreddit_id], @post.id)
           end
       else
          errors.add :base, "Subreddit does not exist."
          render 'new'

       end
    end

    def show
        @post = Post.find_by_id(params[:id])
    end
    
    def destroy
    end
end
