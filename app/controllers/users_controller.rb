class UsersController < ApplicationController

    before_action :find_user, only:[:update]

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
    end

    def update
        if current_user.update(user_params)
            flash.alert = "Successfully Updated"
            redirect_to root_path
        else
            flash.alert = "Please enter a valid email"
            render :edit
        end
    end

    def edit_password 
      @user = current_user
    end

    def update_password
      @user = current_user
      puts"**************************"
      puts (@user.authenticate(params.require(:user).permit(:current_password)))
      puts params[:user][:current_password]
      puts"**************************"
      # if @user && @user.authenticate(params.require(:user).permit(:current_password))
      if @user.authenticate(params[:user][:current_password])
        if password_same?
          if @user.update(params.require(:user).permit(:password))
            redirect_to root_path, {alert: "Password updated!"}
          else
            redirect_to user_edit_password_path, {alert: @user.errors.full_messages.join(", ")}
          end
        else
          redirect_to user_edit_password_path, {alert: "Password confirmation doesn't match", status: 303}
        end
      else
        redirect_to user_edit_password_path, {alert: "Old Password is incorrect", status: 303}
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

    def password_same?
      if (params[:user][:password] != params[:user][:current_password]) && (params[:user][:password] === params[:user][:password_confirmation])
        true
      else
        false
      end
    end
  end