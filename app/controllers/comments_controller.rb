class CommentsController < ApplicationController
  invisible_captcha :only => [:create]
  expose(:post_comments) { post.comments }
  expose(:new_comment) { Comment.new }

  helper_method :post, :comment

  def create
    @comment = post.comments.build(comment_params)
    @comment.ip = request.remote_ip
    if @comment.save
        respond_to do |format|
          format.html {
            flash[:success] = "Your comment was saved successfully."
            redirect_to post_path(post, :anchor => "comment_#{comment.id}")
          }
          format.js
        end
    else
      flash[:danger] = "There was an error saving your comment."
      redirect_to post_path(post), new_comment: post.comments.build(comment_params)
    end
  end

  def destroy
    @post = comment.post
    if comment.delete
      Post.reset_counters(@post.id)
      flash[:success] = "The comment ##{comment.id} has been deleted successfully."
      redirect_to @post
    else
      flash[:danger] = "The comment could not be deleted."
      redirect_to post_path(post, :anchor => "comment_#{comment.id}")
    end
  end

  private

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def post
    @post ||= Post.includes(:comments).find_by_param(params[:post_id]).first
  end

  def comment_params
    params.require(:comment).permit(:text,:website,:signature,:post_id)
  end
end
