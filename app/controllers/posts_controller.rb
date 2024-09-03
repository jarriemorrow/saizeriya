class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_post, only: %i[edit update destroy]
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    @post.post_tags.build
    @post.course_menus.build
    @post.arrange_menus.build
    @post.pairing_menus.build
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
    @post = Post.includes(:course_menus, :arrange_menus, :pairing_menus).find(params[:id])
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other
  end

  def likes
    @q = current_user.like_posts.ransack(params[:q])
    @like_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :recipe_name,
      :body, 
      post_tags_attributes: [
        :id, 
        :tag_id
      ], 
      course_menus_attributes: [
        :id, 
        :menu_id, 
        :course_section_id, 
        :_destroy
        ],
      arrange_menus_attributes: [
        :id,
        :menu_id,
        :_destroy
      ],
      pairing_menus_attributes: [
        :id,
        :menu_id,
        :_destroy
      ]
    )
  end
end