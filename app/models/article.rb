class Article < ActiveRecord::Base
  belongs_to :User
  has_many :commentaries
  has_many :tips
  has_many :draws
  validates :user_id, presence: true
end
