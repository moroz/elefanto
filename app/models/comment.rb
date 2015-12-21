class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => :comments_count
  validates :text, :presence => true
  validates :signature, :presence => true
  before_save :add_http
  validates :text, :uniqueness => { :scope => :post_id, :message => "cannot post identical comments" }

  def add_http
    self.website = "http://" + self.website unless self.website.empty?
  end
end
