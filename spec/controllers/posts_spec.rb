require 'rails_helper'

RSpec.describe 'Posts', :type => ['request', 'feature'] do
  before :each do
    @user = User.new(
      name: 'Felix',
      bio: 'Software Developer',
      photo: 'http://hello.com/org.png',
      posts_counter: 0
    )
    @user.save
  end

  it 'renders the correct posts page' do
    get '/users/1/posts'
    expect(response.status).to eq(200)
    expect(response).to render_template('index')
  end

  it 'renders the correct single post page' do
    get '/users/1/posts/1'
    expect(response.status).to eq(200)
    expect(response).to render_template('show')
  end

  it 'renders index template with right text' do
    visit '/users/1/posts/'
    expect(page).to have_text('Users posts')
  end

  it 'renders show template with right text' do
    visit '/users/1/posts/1'
    expect(page).to have_text('Single Post View')
  end
end
