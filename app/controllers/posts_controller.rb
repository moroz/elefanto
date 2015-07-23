class PostsController < ApplicationController
  def show
    @post = Post.find_by_id_or_title(params[:id])
    # if @post.nil?
    #   if allowed?
    #     @post = current_user.posts.build(:title => params[:id])
    #     @title = "Creating new post"
    #     render 'new'
    #   else
    #     flash[:error] = "There is no such post."
    #     redirect_to root_path
    #   end
    # else
      @title = "Presenting post: #{@post.title}"
      # @new_comment = @post.comments.build
      # @comments = @post.comments.paginate(:page => params[:page])
      # @categories = @post.categories
      # session[:post_id] = @post.id
      @post.increment_views
      # if @post.number != 0
        # @previous_post = Post.blog.where("number < #{@post.number}").first
        # @next_post = Post.blog.where("number > #{@post.number}").last
      # end
    # end
  end
end
