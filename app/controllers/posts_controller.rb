require 'will_paginate/array'
class PostsController < ApplicationController


    URL_REGEX_PLAIN = /^(?![www])[a-zA-Z0-9]+\.[a-z]{2,3}/
    URL_REGEX_WWW = /^www\.[a-zA-Z0-9]+\.[a-z]{2,3}/

    
    def new
      @post = Post.new(params[:subreddit_id])
      @subname = params[:subname]
    end

    def create 
        
        url = params[:post][:url]
        if(url =~ URL_REGEX_PLAIN)
            params[:post][:url] = "http://www." + params[:post][:url]
        elsif(url =~ URL_REGEX_WWW)
            params[:post][:url] = "http://" + params[:post][:url]
        else
            url
        end
        @post = Post.create(params[:post]) 
        @post.user_id = current_user.id
        @post.karma = 0
        sub = Subreddit.find_by_subname(params[:post][:subname])
        unless sub.nil?
            if @post.save
                flash[:success] = "Your post has been created!"
                redirect_to subreddit_post_path(sub.subname, @post.id)
            elsif params[:post][:is_link] == "true"
                 render 'posts/_link_post_form'                
            else
                 render 'posts/_text_post_form'                
             end
        else
            @post.errors.add(:base, "Subreddit does not exist.")
            if params[:post][:is_link] == "true"
                 render 'posts/_link_post_form'                
            else
                 render 'posts/_text_post_form'                
             end
        end
    end

    def show
        @post = Post.find_by_id(params[:id])
        @post.karma = @post.votes.where(:post_id => @post.id, :direction => "up").count - @post.votes.where(:post_id => @post.id, :direction => "down").count
        @comment = Comment.new
        @comments = Comment.paginate(:page => params[:page])
        @comments = Comment.where(:post_id => @post.id)
        ids = @comments.map(&:id)
        @replies = Reply.where('comment_id in (?)',  ids)
        #logger.info "**********REPLIES FROM CONTROLLER #{@replies.inspect}"
        @subreddit = Subreddit.find_by_subname(@post.subname)
        @sub = Subreddit.find_by_subname(@post.subname)
    end

    
    def destroy
    end

    def vote
        @user = current_user
        @post = Post.find(params[:post_id])
        @direction = params[:direction]
        @vote_has_been_destroyed = false
        if @user.has_voted?(@post)
            
            @vote = @user.votes.where("post_id = ?", @post.id).first
            #logger.info "********************************VOTE   #{@vote.inspect}   ********************"
            dir = @vote.direction
            #logger.info "********************************DIR   #{dir}   ********************"
            if dir == "up" && @direction == "up"
                @vote.destroy
                @vote_has_been_destroyed = true
                @post.decrease_karma
            elsif dir == "down" && @direction == "down"
                @vote.destroy
                @vote_has_been_destroyed = true
                @post.increase_karma
            elsif dir == "down" && @direction == "up"
                @vote.direction = @direction
                @post.increase_karma
                @post.increase_karma
            elsif dir == "up" && @direction == "down"
                @vote.direction = @direction
                @post.decrease_karma
                @post.decrease_karma
            end
            @vote.save!
            logger.info "********************************VOTE   #{@vote_has_been_destroyed}   ********************"
            logger.info "********************************VOTE   #{@direction}   ********************"

        else
            @user.build_vote(:user_id => @user.id, :post_id => @post.id, :direction => @direction).save!
            if  @direction == "up"
                @post.increase_karma
            end
            if  @direction == "down"
                @post.decrease_karma
            end
        end
       
        respond_to do |format| 
            format.html { redirect_to subreddit_post_path(Subreddit.find_by_subname(@post.subname).id, @post.id)}
            format.js
        end
    end

   
  
end
