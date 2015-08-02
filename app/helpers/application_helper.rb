module ApplicationHelper
  def count_words(string, chinese = false)
    unless chinese
      strip_tags(string).split.length
    else
      strip_tags(string).split('').length
    end
  end

  def background
    images = ["background-sand.jpg", "background-spain.jpg",
      "background-night.jpg", "background-xian.jpg", "background-creatures.jpg", "background-tht.jpg", "background-gate.jpg",
      "background-buddha.jpg", "background-tatooine.jpg"]
    path = "url(/images/backgrounds/" + images.shuffle.first + ")"
  end

  def logged_in?
    return true if current_user
    nil
  end

  def current_locale
    I18n.locale
  end
end
