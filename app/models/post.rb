class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :url, uniqueness: true;
  validates :content, presence: true
  has_many :comments
  has_many :visits
  has_and_belongs_to_many :categories
  before_save :set_word_count, :set_url
  cattr_reader :per_page

  scope :blog, -> { where('posts.number > ?', 0).order(:number => :desc) }
  scope :lang_zh, -> { where(:language => ["zh","zh-hans","zh-hant"]) }
  scope :lang_pl, -> { where(:language => "pl") }
  scope :lang_en, -> { where(:language => "en") }

  @@per_page = 25
  LANGUAGES = {"en" => "English", "pl" => "Polish", "zh" => "Chinese",
    "zh-hans" => "Chinese (Simplified)", "zh-hant" => "Chinese (Traditional)", "es" => "Spanish", "ru" => "Russian"}

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

  def read_number
    return "" if number.nil? || number == 0
    if number == number.floor
      return "%d. " % number
    else
      return (("%.1f. " % number).sub('.', ','))
    end
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

  def set_url
    str = if self.url.empty?
      "#{read_number} #{title}"
    elsif !self.url.match(/\A\d{1,3}-.+/)
      "#{read_number} #{url}"
    end
    self.url = str.to_url
  end

  def set_url!
    Post.record_timestamps = false
    self.set_url
    self.save
    Post.record_timestamps = true
  end

  def is_chinese?
    ["zh","zh-hans","zh-hant"].include?(self.language)
  end

  def to_param
    url
  end

  def self.find_by_param(input)
    self.where url: input
  end

  def no_tags
    ActionController::Base.helpers.strip_tags(self.content)
  end

  def readable_number
    return "" if number.blank? || number.zero?
    int, dec = number.divmod(1)
    str = int.to_s
    str << ",%1d" % (dec*10) unless dec.zero?
    str << ". "
  end

  def title_with_number
    readable_number + self.title
  end

  private

  def count_words
    if is_chinese?
      no_tags.scan(/\p{Han}/).length
    else
      no_tags.split.length
    end
  end
end
