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
end
