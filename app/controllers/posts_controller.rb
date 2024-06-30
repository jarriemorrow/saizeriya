class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @menus = Menu.all
    @tags = Tag.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      update_menus_and_tags
      redirect_to @post, notice: 'Post was successfully created.'
    else
      @menus = Menu.all
      @tags = Tag.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:body, menu_ids: [], tag_ids: [])
  end

  def update_menus_and_tags
    @post.menus = Menu.where(id: params[:post][:menu_ids])
    @post.tags = Tag.where(id: params[:post][:tag_ids])
  end
end