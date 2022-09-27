require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'show page' do
    before(:each) do
      @user = User.create(name: 'Tom', bio: 'Software Developer', photo: 'http://hello.com/org.png', posts_counter: 0)
      @post = Post.create(title: 'one post', text: 'first post', author_id: @user.id, comments_counter: 0,
                          likes_counter: 0)
      @post_one = Post.create(title: 'two post', text: 'second post', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      @post_two = Post.create(title: 'three post', text: 'third post', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      Comment.create(text: 'welcome to the city', author_id: @user.id, post_id: @post_one.id)
      Comment.create(text: 'This movie is good', author_id: @user.id, post_id: @post_one.id)
      Comment.create(text: 'I love Africa', author_id: @user.id, post_id: @post_two.id)
      Like.create(post_id: @post.id, author_id: @user.id)
      Like.create(post_id: @post_one.id, author_id: @user.id)
      Like.create(post_id: @post_two.id, author_id: @user.id)
    end

    it 'I can see who wrote the post.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Tom')
    end

    it "I can see the post's title." do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('one post')
    end

    it 'I can see the post body.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('first post')
    end

    it 'I can see how many comments a post has.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Comments: 0')
    end

    it 'I can see how many likes it has.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Likes: 1')
    end

    it 'I can see the username of each commentor.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Tom')
    end

    it 'I can see the comment each commentor left.' do
      visit user_post_path(@user.id, @post_one.id)
      expect(page).to have_content('welcome to the city')
    end
  end
end
