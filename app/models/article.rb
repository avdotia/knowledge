class Article < ActiveRecord::Base
  attr_accessible :content, :title
  validates :title, :content, presence: true
  validates :title, length: { maximum: 50 }
  has_and_belongs_to_many :tags
  translates :title, :content

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ? or content LIKE ? ', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
end
