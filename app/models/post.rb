class Post < ActiveRecord::Base
#  attr_accessible :title, :number, :textile_enabled, :content, :description
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  cattr_reader :per_page
  @@per_page = 25

  def self.find_by_id_or_title(string)
    unless string.to_i == 0
      post = self.where(id: string.to_i)
    else
      post = self.where(:title => string)
    end
      post.exists? ? post.first : nil
  end

  def increment_views
    Post.increment_counter(:views, self.id)
  end

  def lang_versions
    self.class.where("number = ? and id <> ?", number, id).to_a
  end

  def previous_post
    self.class.where("number < ?", number).last
  end

  def next_post
    self.class.where("number > ?", number).first
  end

  scope :blog, -> {
    where('posts.number > ?', 0).order(number: :desc)
  }
end
