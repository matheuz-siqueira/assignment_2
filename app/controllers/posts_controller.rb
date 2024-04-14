class PostsController < ApplicationController
  before_action :find_post, only: %i[ show edit update ] 
  before_action :post_params, only: %i[ create update ] 


  def show; end

  def new
    unless session[:user_id]
      flash[:alert] = "you must be logged in to create a post"
    end
    @post = Post.new 
  end

  def create
    if @current_user 
      @post = Post.new(post_params) 
      @post.user = @current_user 

      if @post.save
          flash[:notice] = "Post created successfully"
          redirect_to root_path  
      else
        flas[:alert] = "Your post couldn't be created"
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
  end 

  def update  
    if @post.update(post_params)  
        flash[:notice] = 'Post updated successfully!'
        redirect_to feed_path  
    else 
        flash[:alert] = "Your post couldn't be updated!"
        redirect_to :edit, status: :unprocessable_entity
    end
  end

  private 
    def find_post
      @post = Post.find(params[:id]) 
    end

    def post_params 
      params.require(:post).permit(:title, :body)
    end
end
