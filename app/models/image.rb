class Image < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: true }
  validates :url, presence: true
end
