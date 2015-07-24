module ApplicationHelper
  def count_words(string, chinese = false)
    unless chinese
      strip_tags(string).split.length
    else
      strip_tags(string).split('').length
    end
  end
end
