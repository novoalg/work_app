class SubredditsController < ApplicationController
    def show
        @subreddits = Subreddit.find_by_subname(params[:id])
        logger.info "******************#{@subreddits.inspect}"
        @posts = Post.where(:subname => @subreddits.subname)
        @posts = @posts.paginate(:page => params[:page], :per_page => 2)
    end

    def new
        @subreddits = Subreddit.new
    end

    def index
        @subreddits = Subreddit.all
        @subreddits = Subreddit.paginate(:page => params[:page])
    end

    def create 
        @subreddits = Subreddit.create(params[:subreddit])
        if @subreddits.save 
            flash[:success] = "Your subreddit has been created!" 
            redirect_to @subreddits
        else
            render 'new'
        end
    end
   
    def destroy
    end

end
