# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @like = parent_post.likes.build(user_id: current_user.id)

    if @like.save
      redirect_to parent_post
    else
      redirect_to parent_post, status: :unprocessable_entity
    end
  end

  def destroy
    @post_like = parent_post.likes.find_by(user_id: current_user.id)

    @post_like&.destroy

    redirect_to parent_post
  end

  def parent_post
    @parent_post ||= Post.find params[:post_id]
  end
end
