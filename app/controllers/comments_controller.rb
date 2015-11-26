class CommentsController < ApplicationController
  before_filter :find_post
  invisible_captcha :only => [:create]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.ip = request.remote_ip
    if @comment.save

        respond_to do |format|
          format.html {
            flash[:success] = "Your comment was saved successfully."
            redirect_to post_path(@post, :anchor => "comment_#{@comment.id}")
          }
          format.js
        end
    else
      flash[:danger] = "There was an error saving your comment."
      @new_comment = @comment
      render :template => "posts/show", post: @post, lang_versions: @post.lang_versions
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    id = @comment.id
    @post = @comment.post
    if @comment.delete
      flash[:success] = "The comment ##{id} has been deleted successfully."
      redirect_to @post
    else
      flash[:danger] = "The comment could not be deleted."
      redirect_to post_path(@post, :anchor => "comment_#{id}")
    end
  end

  def comment_params
    params.require(:comment).permit(:text,:website,:signature,:post_id)
  end

  def find_post
    id = params[:post_id] || params[:id]
    @post = Post.find(id)
  end
end
