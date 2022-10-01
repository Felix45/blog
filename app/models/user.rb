class User < ApplicationRecord
  require 'securerandom'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  before_validation :default_values

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order('created_at Desc').last(3)
  end

  private

  def default_values
    self.posts_counter = 0
    self.photo = 'https://img.myloview.com/posters/social-media-user-icon-default-avatar-profile-image-400-251200036.jpg'
  end
end
