class Report < ApplicationRecord
  # after_create :send_confirmation_email

  belongs_to :user
  belongs_to :status

  validates :address, presence: true
  validates :content, presence: true, length: { minimum: 20 }
  validates :title, presence: true, length: { minimum: 15, maximum: 60 }

  has_many_attached :images


  validate :validate_images

  def send_confirmation_email
    ReportMailer.report_confirmation(self.user).deliver_now
    ReportMailer.admin_report_notification(self.user).deliver_now
  end

  private

  def validate_images
    if images.count > 3
      errors.add(:images, 'Vous ne pouvez ajouter que 3 images maximum.')
    end
  end
end
