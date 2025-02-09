# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = Post.order('created_at DESC').includes(:creator)
  end

  def show
    @post = Post.find params[:id]
    @comments_tree = @post.comments.includes(:user).order('created_at DESC').arrange
    @comment = PostComment.new
    @post_user_like = @post.likes.find_by user: current_user
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find params[:id]
    return if current_user.id == @post.creator_id

    redirect_to posts_url, notice: t('.access_error')
    nil
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find params[:id]

    unless current_user.id == @post.creator_id
      redirect_to posts_url, notice: t('.access_error')
      return
    end

    if @post.update(post_params)
      redirect_to @post, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find params[:id]

    unless current_user.id == @post.creator_id
      redirect_to posts_url, notice: t('.access_error')
      return
    end

    @post.destroy

    redirect_to posts_url, notice: t('.success')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
