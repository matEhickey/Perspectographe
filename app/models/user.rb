class User < ActiveRecord::Base
  has_many :articles
  has_many :commentaries
  validates :pseudo, presence: true
  
  validates :firstname, presence: true
  validates :name, presence: true
  validates :age, presence: true
  validates :email, presence: true
end
