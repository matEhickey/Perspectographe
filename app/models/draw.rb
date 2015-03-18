class Draw < ActiveRecord::Base
  belongs_to :Article
  validates :postIt_id, presence: true
end
