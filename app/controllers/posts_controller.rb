class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
  end

  def new
    @post = Post.new
    @menus = Menu.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @post.menus = Menu.where(id: params[:post][:menu_ids])
      redirect_to @post, notice: 'Post was successfully created.'
    else
      @menus = Menu.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:body, menu_ids: [])
  end
end