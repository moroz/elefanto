class PostsController < ApplicationController
  before_action :find_post, :only => [:show,:edit,:update,:destroy]
  include LoggedIn
  include PostNumber
  include ClientData

  def show
    if @post.nil?
      no_such_post(params[:id])
    else
      @title = I18n.t("elefanto") + ": #{post_number(@post.number)}#{@post.title}"
      @new_comment = Comment.new
      @comments = @post.comments.paginate(:page => params[:page])
      session[:post_id] = @post.id
      @post.increment_views(request.remote_ip, browser.bot?, browser_name, request.location)
      @lang_versions = @post.lang_versions
      @previous_post = @post.previous_post
      @next_post = @post.next_post
      if @post.id == 185
        params[:locale] = "zh"
      end
    end
  end

  def index
    if params[:show_all]
      scope = Post.all.order(number: :desc)
    elsif params[:lang]
      if params[:lang] == "zh"
        scope = Post.where(:language => ["zh","zh-hans","zh-hant"]).order(number: :desc)
      else
        scope = Post.where(:language => params[:lang]).order(number: :desc)
      end
    else
      scope = Post.blog
    end
    @posts = scope.paginate(:page => params[:page])
    @title = "Elefanto — blog archive"
  end

  def new
    if only_authorized
      @post = Post.new(:number => Post.blog.first.number + 1, :textile_enabled => true)
      @title = "Create new post"
    end
  end

  def create
    if only_authorized
      @post = Post.new(post_params)
      @post.save
      redirect_to @post
    end
  end

  def edit
    if only_authorized(@post)
      post_number = post_number(@post.number)
      @title = "Editing post #{post_number}#{@post.title}"
      render 'new'
    end
  end

  def update
    if only_authorized(@post)
      if @post.update_attributes(post_params)
        flash[:success] = "The post was successfully saved."
        redirect_to @post
      else
        @post.attributes = post_params
        render 'edit'
      end
    end
  end

  def destroy
    if only_authorized(post_path(@post))
      if @post.delete
        flash[:success] = "The post was successfully destroyed."
        redirect_to root_path
      else
        flash[:error] = "The post cannot be removed."
        redirect_to post_path(@post)
      end
    end
  end

  private

    def no_such_post(id)
      logger.error "Attempt to access inexistent post #{id}, from #{request.remote_ip}."
      flash[:danger] = "There is no such post."
      redirect_to posts_path
    end

    def find_post
      @post = Post.find_by_id_or_title(params[:id])
    end

    def post_params
      params.require(:post).permit(:title,:number,:content,:description,:textile_enabled,:language,:order,:show_all)
    end
end
