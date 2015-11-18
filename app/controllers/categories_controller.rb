class CategoriesController < ApplicationController
  include LoggedIn

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.order(:number => :desc)
  end

  def edit
    if only_authorized(categories_url)
      @category = Category.find(params[:id])
      @header = "Editing category: #{@category.name_en}"
    end
  end

  def new
    if only_authorized(categories_url)
      @category = Category.new
      @header = "Create a new category"
      render 'edit'
    end
  end

  def create
    if only_authorized(categories_url)
      @category = Category.create(category_params)
      if @category.save
        flash[:success] = "The category #{@category.name} was successfully created."
        redirect_to categories_url
      else
        flash[:danger] = "There was a problem processing your request."
        render 'edit'
      end
    end
  end

  def manage
    if only_authorized(categories_url)
      @category = Category.find(params[:id])
      @posts = Post.all
    end
  end

  def add_post
    if only_authorized(categories_url)
      @category = Category.find(params[:id])
      @post = Post.find(params[:post_id])
      respond_to do |format|
        if @category.posts.include?(@post)
          format.html { flash[:warning] = "This post is already in the category." }
          redirect_to manage_category_path(@category)
        else
          @category.posts << @post
          format.html {
            flash[:success] = "The post \"#{@post.title}\" was added to the category."
            redirect_to manage_category_path(@category)
          }
          format.js
        end
      end
    end
  end

  def remove_post
    if only_authorized(categories_url)
      @category = Category.find(params[:id])
      @post = Post.find(params[:post_id])
      respond_to do |format|
        unless @category.posts.include?(@post)
          format.html { flash[:warning] = "This post doesn't belong to the category." }
          redirect_to manage_category_path(@category)
        else
          @category.posts.delete(@post)
          format.html {
            flash[:success] = "The post \"#{@post.title}\" was removed from the category."
            redirect_to manage_category_path(@category)
          }
          format.js
        end
      end
    end
  end

  def remove
    if only_authorized(categories_url)
      @category = Category.find(params[:id])
      @posts = @category.posts
    end
  end

  private
    def category_params
      params.require(:category).permit(:name_en,:name_pl,:name_zh,:description)
    end
end
