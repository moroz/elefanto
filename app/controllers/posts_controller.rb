class PostsController < ApplicationController
  def show
    @post = Post.find_by_id_or_title(params[:id])
    if @post.nil?
    #   if allowed?
    #     @post = current_user.posts.build(:title => params[:id])
    #     @title = "Creating new post"
    #     render 'new'
    #   else
        flash[:error] = "There is no such post."
        redirect_to root_path
    #   end
    else
      @title = "Elefanto: #{@post.number}. #{@post.title}"
      # @new_comment = @post.comments.build
      # @comments = @post.comments.paginate(:page => params[:page])
      # @categories = @post.categories
      # session[:post_id] = @post.id
      @post.increment_views
      # if @post.number != 0
        # @previous_post = Post.blog.where("number < #{@post.number}").first
        # @next_post = Post.blog.where("number > #{@post.number}").last
      # end
    end
  end

  def index
    @posts = Post.blog.paginate(:page => params[:page])
    @title = "Elefanto — blog archive"
  end

  def new
    unless logged_in?
      flash[:error] = "You are not allowed to perform this action"
      redirect_to 'pages#home'
    else
      @post = Post.new(:number => Post.blog.first.number + 1, :textile_enabled => true)
      @title = "Create new post"
    end
  end

  def create
    unless logged_in?
      flash[:error] = "You are not allowed to perform this action"
      redirect_to 'pages#home'
    else
      @post = Post.new(post_params)
      @post.save
      redirect_to @post
    end
  end

  def edit
    @post = Post.find_by_id_or_title(params[:id])
    unless logged_in?
      flash[:error] = "You are not allowed to perform this action"
      redirect_to @post
    else
      @title = "Edit post #{@post.title}"
      render 'new'
    end
  end

  def update
    @post = Post.find_by_id_or_title(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "The post was successfully saved."
      redirect_to @post
    else
      @post.attributes = post_params
      render 'edit'
    end
  end

  def post_params
    params.require(:post).permit(:title,:number,:content,:description,:textile_enabled)
  end

  def destroy
    @post = Post.find_by_id_or_title(params[:id])
    if not logged_in?
      flash[:error] = "You are not allowed to perform this action"
      redirect_to post_path(@post)
    elsif
      flash[:success] = "The post was successfully destroyed."
      redirect_to root_path
    else
      flash[:error] = "The post cannot be removed."
      redirect_to post_path(@post)
    end
  end
end
