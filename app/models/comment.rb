class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :report
  validates :content, presence: true
  has_many :replies, dependent: :destroy
end
