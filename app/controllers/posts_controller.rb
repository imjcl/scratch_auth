class PostsController < ApplicationController
  before_action :require_login, only: [:new, :edit]
  def index
    @posts = Post.all
  end

  def new
    if logged_in?
      @post = Post.new
    else
      redirect_to root_path
    end
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
    @post = Post.find_by(slug: params[:slug])
  end

  def edit
    if logged_in?
      @post = Post.find_by(slug: params[:slug])
    else
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:slug])
    @post.update_attributes(post_params)
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end