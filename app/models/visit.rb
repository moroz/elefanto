class Visit < ActiveRecord::Base
  before_save :set_timestamp
  cattr_reader :per_page
  belongs_to :post
  @@per_page = 50

  def set_timestamp
    self.timestamp = Time.now
  end
end
