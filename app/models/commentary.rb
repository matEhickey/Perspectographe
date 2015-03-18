class Commentary < ActiveRecord::Base
  belongs_to :Article
  validates :article_id, presence: true
end
