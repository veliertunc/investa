class User < ApplicationRecord
  enum :role, [ :founder, :investor ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :startup, dependent: :destroy
  has_one :investor_profile, dependent: :destroy
end
