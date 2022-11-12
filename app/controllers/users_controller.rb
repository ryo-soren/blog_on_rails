class UsersController < ApplicationController

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path 
        flash.alert = "Logged In!"
      else
        flash.alert = @user.errors.full_messages.join(", ")
        render 'new'
      end
    end
    
    def edit
        @user = current_user
        puts "**************************"
        puts current_user
        puts "**************************"
    end

    def update
        if current_user.update(user_params)
            flash[:success] = "Successfully Updated"
            redirect_to @user
        else
            flash[:error] = "Failed to update"
            render :edit
        end
    end
    
    private

    def find_user
        @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end