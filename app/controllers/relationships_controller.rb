class RelationshipsController < ApplicationController

    def create
        @post = Post.find(params[:relationship][:upvote_id])
        current_user.upvote!(@post)
        respond_to do |format|
          format.html { redirect_to @post }
          format.js
        end
    end

    def destroy
        @post = Relationship.find(params[:id]).upvote
        current_user.deupvote!(@post)
        respond_to do |format|
          format.html { redirect_to @post }
          format.js
        end

    end
end
