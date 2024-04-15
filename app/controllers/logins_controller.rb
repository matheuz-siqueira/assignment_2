class LoginsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id])
    redirect_to feed_path if user 
    @user = User.new 
  end

  def create
    @user = User.find_by(login_params)

    if @user
      session[:user_id] = @user.id
      redirect_to feed_path  
    else 
      flash[:alert] = "Email or password is wrong!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # binding.pry
    if session[:user_id]
      session[:user_id] = nil 
      flash[:notice] = 'Logged out successfully'
      redirect_to root_path
    end  
  end

  private 
    def login_params
      params.require(:user).permit(:email, :password)
    end
end
