class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :super_admin, :support_admin, :content_manager ]

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "role", "created_at", "updated_at" ]
  end
end
