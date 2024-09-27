class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    if params[:q] && params[:q][:recipe_name_or_body_or_course_related_menus_menu_name_or_arrange_related_menus_menu_name_or_pairing_related_menus_menu_name_or_tags_name_cont_all]
      keywords = params[:q][:recipe_name_or_body_or_course_related_menus_menu_name_or_arrange_related_menus_menu_name_or_pairing_related_menus_menu_name_or_tags_name_cont_all].split(/[[:space:]]+/)
      @posts = Post.search_multiple_keywords(keywords)
                   .includes(:user, :likes)
                   .order(created_at: :desc)
                   .page(params[:page])
    else
      @posts = @q.result(distinct: true)
                 .includes(:user, :likes)
                 .order(created_at: :desc)
                 .page(params[:page])
    end
  end
  

  def new
    @post = Post.new
    build_associations(@post)
    @course_sections = CourseSection.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      build_associations(@post) # renderに戻った際に、associationsがnilにならないようにした
      @course_sections = CourseSection.all
      render :new
    end
  end

  def show
    @post = Post.includes(:post_tags, :tags, :likes, :course_menus, :arrange_menus, :pairing_menus)
                .find(params[:id])
  end
  
  def edit
    build_associations(@post)
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      build_associations(@post)
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other
  end

  def likes
    @q = current_user.like_posts.ransack(params[:q])
  
    if params[:q] && params[:q][:recipe_name_or_body_or_course_related_menus_menu_name_or_arrange_related_menus_menu_name_or_pairing_related_menus_menu_name_or_tags_name_cont_all].present?
      keywords = params[:q][:recipe_name_or_body_or_course_related_menus_menu_name_or_arrange_related_menus_menu_name_or_pairing_related_menus_menu_name_or_tags_name_cont_all].split(/[[:space:]]+/)
      
      @like_posts = current_user.like_posts.includes(:post)
                                .merge(Post.search_multiple_keywords(keywords))
                                .order(created_at: :desc)
                                .page(params[:page])
    else
      @like_posts = @q.result(distinct: true)
                      .includes(:post)
                      .order(created_at: :desc)
                      .page(params[:page])
    end
  end
  

  private

  def set_post
    @post = current_user.posts.includes(:course_menus, :arrange_menus, :pairing_menus).find(params[:id])
    @course_sections = CourseSection.all
  end

  def build_associations(post)
    post.post_tags.build if post.post_tags.empty?
    post.course_menus.build if post.course_menus.empty?
    post.arrange_menus.build if post.arrange_menus.empty?
    post.pairing_menus.build if post.pairing_menus.empty?
  end

  def post_params
    params.require(:post).permit(
      :recipe_name,
      :body, 
      images: [],
      post_tags_attributes: [:id, :tag_id], 
      course_menus_attributes: [:id, :menu_id, :course_section_id, :_destroy],
      arrange_menus_attributes: [:id, :menu_id, :_destroy],
      pairing_menus_attributes: [:id, :menu_id, :_destroy]
    )
  end
end
