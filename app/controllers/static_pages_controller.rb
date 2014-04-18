require 'will_paginate/array'
class StaticPagesController < ApplicationController 
  def home
    subscriptions = current_user.subscriptions.map(&:subreddit_id)
    subs = Subreddit.where('id in (?)', subscriptions)
    subnames = subs.map(&:subname)
    @posts = Post.where('subname in (?)', subnames)
    @all_posts = Post.all
    @all_posts = @all_posts.paginate(:page => params[:page], :per_page => 30)
    @posts = @posts.paginate(:page => params[:page], :per_page => 30)
    logger.info "*******ALL_POSTS: #{@all_posts.inspect}"

   
  end

  def help
  end

  def contact
  end
end
