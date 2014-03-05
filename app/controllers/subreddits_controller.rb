class SubredditsController < ApplicationController
    
    def show
        @subreddits = Subreddit.find_by_subname(params[:id])
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
