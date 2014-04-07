class SubredditsController < ApplicationController
    def show
        @subreddit = Subreddit.find_by_subname(params[:id])
        logger.info "******************#{@subreddit.inspect}"
        @posts = Post.where(:subname => @subreddit.subname)
        @posts = @posts.paginate(:page => params[:page], :per_page => 15)
        @posts.each do |p|
            p.karma = p.votes.where(:direction => "up").count - p.votes.where(:direction => "down").count
        end
    end

    def new
        @subreddit = Subreddit.new
    end

    def index
        @subreddits = Subreddit.all
        @subreddits = Subreddit.paginate(:page => params[:page])
    end

    def subscribe
        @user = current_user
        @subreddit = Subreddit.find(params[:subreddit_id])
        @relationship_exists = false

        if @user.has_subbed?(@subreddit)
            @sub = @user.subscriptions.where("subreddit_id = ?", @subreddit.id).first
            @relationship_exists = false
            @subreddit.decrease_user_count
            @sub.destroy
            @sub.save!
        else
            @user.create_subscription(:subreddit_id => @subreddit.id, :user_id => @user.id).save!
            @subreddit.increase_user_count
            @relationship_exists = true
        end
        respond_to do |format| 
            format.html { redirect_to @subreddit }
            format.js
        end

    end

    def create 
        @subreddit = Subreddit.create(params[:subreddit])
        @subreddit.user_count = 0;
        if @subreddit.save 
            flash[:success] = "Your subreddit has been created!" 
            redirect_to subreddit_path(@subreddit.subname)
        else
            render 'new'
        end
    end
   
    def destroy
    end


    def sort(karma)
        @subreddit = Subreddit.find_by_subname(params[:id])
        @posts = Post.where(:subname => @subreddit.subname)
        s = karma
        order = Math.log10([s.abs, 1].max)
        if s > 0
            sign = 1
        elsif s < 0
            sign = -1
        else
            sign = 0
        end
        seconds = Date.today - 1134028003.seconds
        @result = (order + sign * seconds.to_i / 45000).round
        @posts = Post.by_order(@result).all
    end

end
