class Image < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_sensitive: true }
  validates :url, presence: true
end
