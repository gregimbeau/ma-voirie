class Reply < ApplicationRecord
  belongs_to :comment
  validates :content, presence: true
  validates :nickname, presence: true
end
