class Micropost < ApplicationRecord

  validates :content, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user

  scope :created_sort, -> {order created_at: :desc}
end
