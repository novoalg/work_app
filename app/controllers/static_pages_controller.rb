class StaticPagesController < ApplicationController 
  def home
    @subreddits = Subreddit.all
    @posts = Post.all
    logger.info "******************************#{@subreddits.inspect}"
    logger.info "******************************#{@posts.inspect}"
  end

  def help
  end

  def contact
  end
end
