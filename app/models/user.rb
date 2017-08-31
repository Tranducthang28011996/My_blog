class User < ApplicationRecord
  has_secure_password

  attr_accessor :remember_token

  before_save {email.downcase!}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
    length: {maximum: Settings.validates.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :name, presence: true,
    length: {maximum: Settings.validates.maximum_name}
  validates :password, presence: true,
    length: {minimum: Settings.validates.minimum_password},
    confirmation: true
  validates :password_confirmation, presence: true,
    length: {minimum: Settings.validates.minimum_password}

  has_many :active_follows, class_name: Follow.name,
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  has_many :passive_follows, class_name: Follow.name,
    foreign_key: "followed_id",
    dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  has_many :microposts
  has_many :comments

  enum role: [:user, :admin]

  class << self

    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end
end

