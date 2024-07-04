class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:menus, :tags).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    @post.menus.build
    @post.tags.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @post = Post.includes(:menus, :tags).find(params[:id])
  end

  def edit
    @post = Post.includes(:menus, :tags).find(params[:id])
    @post.post_menus.build if @post.post_menus.empty?
    @post.post_tags.build if @post.post_tags.empty?
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end


  private

  def post_params
    params.require(:post).permit(:recipe_name, :body, post_tags_attributes: [:id, :tag_id], post_menus_attributes: [:id, :menu_id])
  end
end