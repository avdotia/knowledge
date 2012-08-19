class Tag < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, length: { maximum: 63 }
  has_and_belongs_to_many :articles
  
end
