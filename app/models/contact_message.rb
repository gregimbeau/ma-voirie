class ContactMessage < ActiveRecord::Base
  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  attr_accessor :captcha

  validate :captcha_must_be_valid

  private

  def captcha_must_be_valid
    errors.add(:captcha, 'doit être validé') unless captcha
  end
end
