class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.order(:number => :desc)
  end

  def edit
    @category = Category.find(params[:id])
    @header = "Editing category: #{@category.name_en}"
  end

  def new
    @category = Category.new
    @header = "Create a new category"
    render 'edit'
  end

  def add
    @category = Category.find(params[:id])
    @posts = Post.all
  end

  def add_post
    @category = Category.find(params[:id])
    @post = Post.find(params[:post_id])
    respond_to do |format|
      if @category.posts.include?(@post)
        format.html { flash[:warning] = "This post is already in the category." }
      else
        @category.posts << @post
        format.html {
          flash[:success] = "The post \"#{@post.title}\" was added to the category."
          redirect_to add_category_path(@category)
        }
      end
    end
  end

  def remove
    @category = Category.find(params[:id])
    @posts = @category.posts
  end
end
