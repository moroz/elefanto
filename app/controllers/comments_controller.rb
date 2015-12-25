class CommentsController < ApplicationController
  invisible_captcha :only => [:create]
  expose(:post)
  expose(:post_comments) { post.comments }
  expose(:comment)
  expose(:new_comment) { Comment.new }

  def create
    comment = post.comments.build(comment_params)
    comment.ip = request.remote_ip
    if comment.save
        respond_to do |format|
          format.html {
            flash[:success] = "Your comment was saved successfully."
            redirect_to post_path(post, :anchor => "comment_#{comment.id}")
          }
          format.js
        end
    else
      flash[:danger] = "There was an error saving your comment."
      self.new_comment = post.comments.build(comment_params)
      # self.post_comments = post.comments
      render :template => "posts/show", post: post, lang_versions: post.lang_versions
    end
  end

  def destroy
    if comment.delete
      Post.reset_counters(post.id)
      flash[:success] = "The comment ##{comment.id} has been deleted successfully."
      redirect_to post
    else
      flash[:danger] = "The comment could not be deleted."
      redirect_to post_path(post, :anchor => "comment_#{id}")
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text,:website,:signature,:post_id)
  end
end
