class PostsController < ApplicationController
  before_action :only_authorized, :only => [:new,:create,:edit,:update,:destroy]

  helper_method :post

  expose(:posts)
  expose(:post_comments) { post.comments.paginate(:page => params[:page]) }
  expose(:new_comment) { Comment.new }

  after_action only: :show do
    Thread.new do
      VisitLogger.new(ip: request.remote_ip, post_id: post.id, location: request.location, browser: browser).log
    end
  end

  def show
    if post.nil?
      no_such_post(params[:id])
    else
      @title = "#{post_number(post.number)}#{post.title}" + t("titles.show_post")
      @lang_versions = post.lang_versions
      @previous_post = post.previous_post
      @next_post = post.next_post
      post.increment_views unless browser.bot?
    end
  end

  def index
    if params[:show_all]
      self.posts = Post.includes(:comments).all
    elsif params[:post_lang]
      case params[:post_lang]
      when "zh"
        self.posts = Post.lang_zh
      when "pl"
        self.posts = Post.lang_pl
      when "en"
        self.posts = Post.lang_en
      else
        self.posts = Post.blog
      end
    else
      self.posts = Post.blog
    end
    self.posts = self.posts.order("number DESC").paginate(:page => params[:page])
    @title = t("titles.blog_archive")
  end

  def new
    number = Post.blog.first.try(:number).to_i + 1
    @post = Post.new(:number => number, :textile_enabled => true)
    @title = "Create new post"
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @title = "Editing post " + post.title_with_number
    render 'new'
  end

  def update
    if post.update(post_params)
      flash[:success] = "The post was successfully saved."
      redirect_to post
    else
      render 'new'
    end
  end

  def destroy
    only_authorized(post_path(post))
    if post.delete
      flash[:success] = "The post was successfully destroyed."
      redirect_to root_path
    else
      flash[:danger] = "The post cannot be removed."
      redirect_to post_path(post)
    end
  end

  def post
    @post ||= Post.includes(:comments).find_by_param(params[:id]).first
  end

  private

  def no_such_post(id)
    logger.error "Attempt to access inexistent post #{id}, from #{request.remote_ip}."
    flash[:danger] = "There is no such post."
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:title,:number,:content,:description,:textile_enabled,:language,:url,:comment_count,:page)
  end
end
