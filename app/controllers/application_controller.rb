class ApplicationController < ActionController::Base
  include CasAuthentication
  include SessionsHelper
  before_filter :login_required
  helper_method :user_karma
  helper_method :user_link_karma
  

  def user_link_karma(id)
    user = User.find(id)
    user_posts = Post.where(:user_id => user.id)
    link_karma = 0
    user_posts.each do |p|
        if p.karma > 0
           link_karma += p.karma
        end
    end
    user.link_karma = link_karma
    user.save!
  end

  def user_karma(id)
    user = User.find(id)
    user_comments = Comment.where(:user_id => user.id)
    karma = 0
    user_comments.each do |p|
        karma += p.karma
    end
    user.karma = karma
    user.save!
  end

  def logout
  end

  def handle_unverified_request
    sign_out
    super
  end

  def will_paginate(collection_or_options = nil, options = {})

  if collection_or_options.is_a? Hash
    options, collection_or_options = collection_or_options, nil
  end

  # Automatically specify the bootstrap renderer
  # Unless the user wants a different renderer.
  unless options[:renderer]
    options = options.merge :renderer => BootstrapPagination::Rails
  end

  # Automatically set the per_page setting to 10
  unless options[:per_page]
    options = options.merge :per_page => 10
  end

  # Call the original implementation
  super *[collection_or_options, options].compact
  end
  
end
