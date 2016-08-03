class Image < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: true }
  # validates :url, presence: true
  has_attached_file :asset, url: ":s3_eu_url", :path => "/assets/:id/:basename_:style.:extension"
  validates_attachment :asset, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
