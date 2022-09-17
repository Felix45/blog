require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(
        name: 'Felix',
        bio: 'Software Developer',
        photo: 'http://hello.com/org.png',
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

  it '@post as created is valid' do
    expect(@post).to be_valid
  end

  it 'post title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'A posts likes_counter should be >= 0' do
    @post.likes_counter = -4
    expect(@post).to_not be_valid
  end

  it 'A posts comments_counter should be numeric' do
    @post.comments_counter = 'One'
    expect(@post).to_not be_valid
  end

  it 'A posts comments_counter should be >= 0' do
    @post.comments_counter = -4
    expect(@post).to_not be_valid
  end

  it 'A posts likes_counter should be numeric' do
    @post.likes_counter = 'One'
    expect(@post).to_not be_valid
  end

  it 'should increment user post_counter by one' do
    user = User.find(@post.author_id)
    expect(user.posts_counter).to eq(1)
  end

  it 'should not accept more than 250 character' do
    @post.title = '
    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
    eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
    montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque
    eu, pretium quis,'
    expect(@post).to_not be_valid
  end

  it 'should return a users last 5 comments' do
    user = User.create(
        name: 'Alex',
        bio: 'Graphic designer',
        photo: 'http://hello.com/org.png',
        posts_counter: 0
    )
    10.times.collect do
      Comment.create(text: 'Hello, world', author_id: user.id, post_id: @post.id)
    end
    expect(@post.five_recent_comments.length).to eq(5)
  end
end
