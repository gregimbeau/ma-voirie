class ContactMessage < ActiveRecord::Base
  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
