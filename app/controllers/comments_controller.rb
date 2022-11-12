class CommentsController < ApplicationController

    before_action :find_post

    def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        
        if @comment.save
            flash.alert = "Comment posted"
            redirect_to @post
        else
            flash.alert = @comment.errors.full_messages.join(", ")
            redirect_to @post
        end
        
    end

    def destroy
        @comment = Comment.find params[:id]
        if @comment.save
            @comment.destroy
            redirect_to post_path(@comment.post)
            flash.alert = "Comment deleted"
        else
            flash.alert = @comment.errors.full_messages.join(", ")
            redirect_to post_path(@comment.post)
        end
    end


    private
    
    def find_post
        @post = posts.find params[:post_id]
    end
    
    def comment_params
        params.require(:comment).permit(:body)
    end

    
end
