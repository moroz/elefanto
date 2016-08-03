class Image < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: true }
  validates :url, uniqueness: true
  has_attached_file :asset, url: ":s3_eu_url", :path => "/assets/:id/:basename_:style.:extension"
  validates_attachment :asset, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  before_create :set_url

  def to_param
    url
  end

  def self.find_by_param(url)
    where(url: url).first
  end

  private

  def set_url
    url = title.to_url
  end
end
