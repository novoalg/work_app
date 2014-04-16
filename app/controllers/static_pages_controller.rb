class StaticPagesController < ApplicationController 
  def home
    subscriptions = current_user.subscriptions.map(&:subreddit_id)
    subs = Subreddit.where('id in (?)', subscriptions)
    subnames = subs.map(&:subname)
    @posts = Post.where('subname in (?)', subnames)
    @all_posts = Post.all
    logger.info "*******ALL_POSTS: #{@all_posts.inspect}"

   
  end

  def help
  end

  def contact
  end
end
