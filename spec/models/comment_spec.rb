require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(
        name: 'Anne',
        photo: 'https://anne.com/ann.jpg',
        bio: 'This Annes bio',
        posts_counter: 0
    )
    @post = Post.create(
        title: 'A new dawn',
        text: 'Software Developer',
        author_id: @user.id,
        comments_counter: 0,
        likes_counter: 0
    )
  end

  it '@users comments_counter should increase by one' do
    Comment.create(text: 'Hello there!!', author_id: @user.id, post_id: @post.id)
    Comment.create(text: 'Welcome home!!', author_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.comments_counter).to eq(2)
  end
end