class PostsController < ApplicationController


    URL_REGEX_PLAIN = /^(?![www])[a-zA-Z0-9]+\.[a-z]{2,3}/
    URL_REGEX_WWW = /^www\.[a-zA-Z0-9]+\.[a-z]{2,3}/
    def new
      @post = Post.new(params[:subreddit_id])
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
        sub = Subreddit.find_by_subname(params[:post][:subname])
        sub_id = sub.id
        #sub = Subreddit.find_by_subname(@post.subname)

        unless sub.nil?
            if @post.save
                flash[:success] = "Your post has been created!"
                redirect_to subreddit_post_path(sub_id, @post.id)
            else
                render 'new'
            end
        else
            @post.errors.add(:base, "Subreddit does not exist.")
            render 'new'
        end
    end

    def show
        @post = Post.find_by_id(params[:id])
    end
    
    def destroy
    end
  
end
