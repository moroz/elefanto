class Post < ActiveRecord::Base
#  attr_accessible :title, :number, :textile_enabled, :content, :description
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  has_many :comments
  has_and_belongs_to_many :categories
  before_save :set_word_count
  cattr_reader :per_page
  @@per_page = 25
  LANGUAGES = {"en" => "English", "pl" => "Polish", "zh" => "Chinese", "es" => "Spanish", "ru" => "Russian"}

  def self.find_by_id_or_title(string)
    if string.to_i == 0
      post = self.find_by(title: string)
    else
      post = self.find_by(id: string)
    end
  end

  def self.latest
    self.order(:updated_at).last
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

  def set_word_count
    self.word_count = count_words(self.content,self.is_chinese?)
  end

  def set_word_count!
    Post.record_timestamps = false
    self.set_word_count
    self.save
    Post.record_timestamps = true
  end

  def is_chinese?
    self.language == "zh"
  end

  scope :blog, -> {
    where('posts.number > ?', 0).order(number: :desc)
  }
  private
  def count_words(string, chinese)
    unless chinese
      ActionController::Base.helpers.strip_tags(string).split.length
    else
      ActionController::Base.helpers.strip_tags(string).split('').length
    end
  end
end
