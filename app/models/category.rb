class Category < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :name_en, :presence => true, :length => {:minimum => 3}, :uniqueness => true
  validates :name_pl, :uniqueness => true, :allow_blank => true
  validates :name_zh, :uniqueness => true, :allow_blank => true

  def name
    self.name_en
  end
end
