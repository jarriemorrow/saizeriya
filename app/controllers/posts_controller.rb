class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:menus, :tags).order(created_at: :desc).page(params[:page])
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

  def edit
    @post = Post.find(params[:id])
    @menus = @post.menus
    @tags = @post.tags
  end


  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      update_menus_and_tags
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
      @menus = @post.menus
      @tags = @post.tags
    end
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