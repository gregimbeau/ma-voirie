class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :user
  validates :content, presence: true
  validates :user_id, presence: true
end
