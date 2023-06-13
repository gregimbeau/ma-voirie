class User < ApplicationRecord
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
  

end
