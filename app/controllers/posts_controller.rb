class PostsController < ApplicationController

    before_action :find_post, only: [:show, :destroy, :edit, :update]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only:[:edit, :update, :destroy]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user

        if @post.save
            flash.alert = "New post created"
            redirect_to @post
        else
            flash.alert = @post.errors.full_messages.join(", ")
            render 'new'
        end
        
    end

    def index
        @posts = Post.order(created_at: :desc)
    end

    def show
        @comments = @post.comments.order(created_at: :desc)
        @comment = Comment.new
    end

    def edit
    end

    def update
        @post.user = current_user

        if @post.update(post_params)
            flash.alert = "Post updated successfully"
            redirect_to @post
        else
            flash.alert = @post.errors.full_messages.join(", ")
            render :edit            
        end
    end

    def destroy
        @post.destroy
        flash.alert = "Post deleted successfully"
        redirect_to posts_path
    end
    
    private

    def find_post
        @post = Post.find params[:id]
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized!" unless can?(:crud, @post)
    end
end
