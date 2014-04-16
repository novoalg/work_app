class UsersController < ApplicationController
  #before_filter :signed_in_user, :only => [:index, :edit, :update, :destroy]
  #before_filter :correct_user, :only => [:edit, :update]
  #before_filter :admin_user, :only => :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_username(params[:id])
    @posts = Post.where(:user_id => @user.id)
    @comments = Comment.where(:user_id => @user.id)
    user_link_karma(@user.id)
    user_karma(@user.id)
           

  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        sign_in @user
        flash[:success] = "Welcome to fake-reddit!"
        redirect_to @user
    else
        render 'new'
    end
  end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            #Handle a successful update
            flash[:success] = "Profile has been updated!"
            sign_in @user
            redirect_to @user
        else
            render 'edit'
        end
    end

    def votes?(post)
        @user.votes = Votes.find_by_post_id(post.id)
    end

    def subscriptions?(subreddit)
        @user.subscriptions = Subscriptions.find_by_subreddit_id(subreddit.id)
    end


    private
    def signed_in_user
        unless logged_in?
            store_location
            redirect_to signin_url, :notice => "Please sign in." 
        end
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end

end
