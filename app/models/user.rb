class User < ApplicationRecord
  after_create :send_welcome
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reports

  validates :nickname, presence: true, on: :user_update
  validates :first_name, presence: true, on: :user_update
  validates :last_name, presence: true, on: :user_update
  validates :phone_number, presence: true, on: :user_update
  validates :age, presence: true, on: :user_update
  
  attr_reader :password_changed
  def password=(new_password)
    @password_changed = true unless new_password.blank?
    super(new_password)
  end

  after_update_commit :send_password_change_email, if: :password_changed

  private

  def send_welcome
    UserMailer.welcome(self).deliver_now
  end


  def send_password_change_email
    UserMailer.password_changed(self).deliver_now
  end

end
