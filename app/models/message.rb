class Message < ActiveRecord::Base
  validates :user_id, presence: true
  validates :otherUser_id, presence: true
end
