class VotesController < ApplicationController
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @vote }
    end
  end

  # GET /votes/new
  def new
    @vote = Vote.new(params[:id])
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  def create
    @vote = Vote.new(params[:vote])
    @user = current_user
    @post = Post.find(params[:id])
    @user = @user.build_vote(params[:vote][:id], @user.id, @post.id, params[:vote][:direction])
    direction = params[:vote][:direction]
    respond_to do |format|
      if @vote.save, direction = "up", @user.
        @post.increase_karma
        format.html { redirect_to subreddit_post_path(Subreddit.find_by_subname(@post.subname).id, @post.id)}
        format.js
      end
      if @vote.save, direction = "down"
        @post.decrease_karma
        format.html { redirect_to subreddit_post_path(Subreddit.find_by_subname(@post.subname).id, @post.id)}
        format.js
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, :notice => 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
end
