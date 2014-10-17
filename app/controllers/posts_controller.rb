class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
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