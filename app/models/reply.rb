class Reply < ApplicationRecord
  belongs_to :comment
  validates :content, presence: true
  validates :user_id, presence: true
end
