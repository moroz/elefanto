class Visit < ActiveRecord::Base
  before_save :set_timestamp

  def set_timestamp
    self.timestamp = Time.now
  end
end
