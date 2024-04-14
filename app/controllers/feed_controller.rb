class FeedController < ApplicationController

  before_action :find_posts, only: %i[ index ]

  def index
    @user = User.find_by(id: session[:user_id])
    # redirect_to new_login_path unless @user   
  end

  private
    def find_posts 
      @posts = Post.all 
    end
end
