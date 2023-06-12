class Report < ApplicationRecord
  belongs_to :user
  belongs_to :status

  validates :address, presence: true
  validates :content, presence: true, length: {minimum: 30}
  validates :title, presence: true, length: {minimum: 15, maximum:60}
end
