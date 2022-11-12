class ApplicationController < ActionController::Base
    def posts 
        @posts = Post.order(created_at: :desc)
    end
end
