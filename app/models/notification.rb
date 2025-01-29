class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read_at: nil) }
  scope :read, -> { where.not(read_at: nil) }

  def mark_as_read!
    update(read_at: Time.current)
  end

  def unread?
    read_at.nil?
  end
end
