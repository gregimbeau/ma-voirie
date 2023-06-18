class User < ApplicationRecord
  after_create :send_welcome

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :reports
  validates :nickname, presence: true
  
  private

  def send_welcome
    UserMailer.welcome(self).deliver_now
  end

  def send_password_change_notification
    UserMailer.password_changed(self).deliver_now
  end

end
