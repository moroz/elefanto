class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text, :presence => true
  validates :signature, :presence => true
  before_save :add_http

  def add_http
    self.website = "http://" + self.website unless self.website.empty?
  end
end
