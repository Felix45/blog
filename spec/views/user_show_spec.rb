require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'show page' do
    before(:each) do
      @user =
        User.create(
          name: 'Tom',
          bio: 'Software Developer',
          photo: 'http://hello.com/org.png',
          posts_counter: 0
        )
      @post = Post.create(title: 'one post', text: 'first post', author_id: @user.id, comments_counter: 0,
                          likes_counter: 0)
      @post_one = Post.create(title: 'two post', text: 'second post', author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
      @post_two = Post.create(title: 'three post', text: 'third post',  author_id: @user.id, comments_counter: 0,
                              likes_counter: 0)
    end

    it "has users's profile picture." do
      visit user_path(@user.id)
        expect(page).to have_xpath("//img[contains(@src,'http://hello.com/org.png')]")
    end

    it "has users's username." do
      visit user_path(@user.id)
      expect(page).to have_content('Tom')
    end

    it "has users's bio." do
      visit user_path(@user.id)
      expect(page).to have_content('Software Developer')
    end

    it 'has users number of posts' do
      visit user_path(@user.id)
      expect(page).to have_content('Number of posts: 3')
    end

    it 'has link to all posts' do
      visit user_path(@user.id)
      expect(page).to have_selector(:link_or_button, 'See all posts')
    end

    it 'has recent three posts' do
      visit user_path(@user.id)
      expect(page).to have_content('one post')
      expect(page).to have_content('second post')
      expect(page).to have_content('third post')
    end

    it 'redirects to user post show page' do
      visit user_posts_path(@user.id)
      expect(page).to have_current_path user_posts_path(@user.id)
    end

    it 'redirects to all user posts page' do
      visit user_path(@user.id)
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user.id)
    end
  end
end
