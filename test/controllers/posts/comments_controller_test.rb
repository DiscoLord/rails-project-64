# frozen_string_literal: true

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @attrs = {
      content: Faker::Lorem.paragraph(sentence_count: 2)
    }
    sign_in @user
  end

  test 'create comment' do
    @post = posts(:three)
    assert_difference('@post.comments.count', 1) do
      post post_comments_url @post, params: { post_comment: @attrs }
    end
    comment = PostComment.find_by @attrs
    assert { comment }
  end

  test 'create subcomment' do
    @post = posts(:two)
    @comment = post_comments(:deep_nested)

    assert_difference('@post.comments.count', 1) do
      post post_comments_url @post, params: { post_comment: @attrs.merge(parent_id: @comment.id) }
    end
    inner_comment = PostComment.where('ancestry LIKE ?', "%/#{@comment.id}")
    assert inner_comment.exists?
  end

  test 'blank comment' do
    @post = posts(:three)
    @attrs = { content: '' }
    assert_no_difference('@post.comments.count') do
      post post_comments_url @post, params: { post_comment: @attrs }
    end
    assert { flash[:notice] == 'Не может быть пустым' }
  end
end
