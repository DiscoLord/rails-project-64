class Posts::CommentsController < ApplicationController
  def create
    @comment = resource_post.comments.build(post_comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to resource_post, notice: "Коммент добавлен"
    else
      redirect_to resource_post, notice: "Пустой комменты >:-("
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end

  def resource_post
    @resource_post ||= Post.find params[:post_id]
  end
end
