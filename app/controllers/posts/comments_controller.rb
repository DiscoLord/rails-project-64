# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = parent_post.comments.build(post_comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to parent_post, notice: t('.success_comment')
    else
      redirect_to parent_post, notice: t('.empty_comment')
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end

  def parent_post
    @parent_post ||= Post.find params[:post_id]
  end
end
