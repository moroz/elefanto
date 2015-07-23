class Post < ActiveRecord::Base
  validates :title, presence: true

  def self.find_by_id_or_title(string)
    unless string.to_i == 0
      post = self.where(id: string.to_i)
    else
      post = self.where(:title => string)
    end
      post.exists? ? post.first : nil
  end
end
