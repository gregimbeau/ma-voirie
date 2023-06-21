class User < ApplicationRecord
  after_create :send_welcome

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :reports
  has_many :comments
  has_many :replies
  has_many :report_likes
  validates :nickname, presence: true

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_h).where("lower(email) = :value OR lower(nickname) = :value", { value: login.downcase }).first
    elsif conditions.key?(:email) || conditions.key?(:nickname)
      where(conditions.to_h).first
    end
  end

  private

  def send_welcome
    UserMailer.welcome(self).deliver_now
  end

  def send_password_change_notification
    UserMailer.password_changed(self).deliver_now
  end

end
