class Report < ApplicationRecord
  belongs_to :user
  belongs_to :status

  validates :address, presence: true
  validates :content, presence: true, length: { minimum: 20 }
  validates :title, presence: true, length: { minimum: 15, maximum: 60 }

  has_many_attached :images

  def pictures_limit_reached?
    pictures.count >= 3
  end
end
