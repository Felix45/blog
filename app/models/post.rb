class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  after_save :update_posts_counter

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end