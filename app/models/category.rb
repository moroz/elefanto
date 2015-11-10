class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts

  validates :name_en, :presence => true, :length => {:minimum => 3}, :uniqueness => true
  validates :name_pl, :uniqueness => true
  validates :name_zh, :uniqueness => true

  def name_pl
    self.name_pl || name_en
  end

  def name_zh
    self.name_zh || name_en
  end

  def name
    self.name_en
  end
end
