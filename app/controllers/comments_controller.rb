class CommentsController < ApplicationController
  before_filter :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.ip = request.remote_ip
    if @comment.save
      flash[:success] = "Your comment was saved successfully."
      redirect_to post_path(@post, :anchor => "comment_#{@comment.id}")
    else
      flash[:danger] = "There was an error saving your comment."
      @new_comment = @comment
      render :template => "posts/show", post: @post, lang_versions: @post.lang_versions
    end
  end

  def comment_params
    params.require(:comment).permit(:text,:website,:signature,:post_id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
