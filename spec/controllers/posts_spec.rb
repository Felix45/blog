require 'rails_helper'

RSpec.describe 'Posts', :type => ['request', 'feature'] do
  it 'renders index template with right text' do
    visit '/users/1/posts/'
    expect(page).to have_text('Users posts')
  end

  it 'renders show template with right text' do
    visit '/users/1/posts/1'
    expect(page).to have_text('Single Post View')
  end
end
