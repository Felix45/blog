require 'rails_helper'

RSpec.describe 'Users', type: %w[request feature] do
  before :each do
    @user = User.new(
      name: 'Felix',
      bio: 'Software Developer',
      photo: 'http://hello.com/org.png',
      posts_counter: 0
    )
    @user.save
  end

  it 'renders the index template' do
    get '/users/'
    expect(response.status).to eq(200)
    expect(response).to render_template('index')
  end

  it 'renders the show template' do
    get '/users/1'
    expect(response.status).to eq(200)
    expect(response).to render_template('show')
  end

  it 'renders index template with right text' do
    visit '/users/'
    expect(page).to have_text('List of users')
  end

  it 'renders show template with right text' do
    visit '/users/1'
    expect(page).to have_text('User profile')
  end
end
