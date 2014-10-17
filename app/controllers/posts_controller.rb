class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @user.save
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def show
    @post = Post.where(title: params[:title])
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end