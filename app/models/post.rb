class Post < ActiveRecord::Base
#  attr_accessible :title, :number, :textile_enabled, :content, :description
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  has_many :comments
  has_and_belongs_to_many :categories
  cattr_reader :per_page
  @@per_page = 25
  LANGUAGES = {"en" => "English", "pl" => "Polish", "zh" => "Chinese", "es" => "Spanish", "ru" => "Russian"}

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
    self.class.where("number < ?", number).order(number: :desc).first
  end

  def next_post
    self.class.where("number > ?", number).order(number: :asc).first
  end

  def set_lang(lang)
    self.language = lang.to_s
    self.save
  end

  def is_chinese?
    self.language == "zh"
  end

  scope :blog, -> {
    where('posts.number > ?', 0).order(number: :desc)
  }
end
