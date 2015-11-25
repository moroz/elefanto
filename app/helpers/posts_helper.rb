module PostsHelper
  include PostNumber

  def do_formatting(str, textile_enabled)
    if textile_enabled
      render_textilized(str)
    else
      render_wiki_code(str)
    end
  end

  def render_textilized(str)
    raw(RedCloth.new(str).to_html)
  end

  def render_wiki_code(str)
    s = str.dup
    s = str.gsub(/'{3}[^']+'{3}/) { |s| "<strong>#{s[3..-4]}</strong>" }
    s = s.gsub(/'{2}([^']+)'{2}/) { |s| "<em>#{s[2..-3]}</em>" }
    s = s.gsub(/\[{2}([\w\d ]+)\]{2}/) { |s| link_to s[2..-3], "/posts/#{s[2..-3]}" }
    #s = word_wrap(s)
    s = simple_format(s)
    return s
  end

  def languages(lang_versions)
    # full_names = {"pl" => "polski", "en" => "English", "zh" => "中文", "ru" => "русский", "de" => "Deutsch", "es" => "español"}
    array = []
    lang_versions.each do |x|
      array << "<a href=\"/posts/#{x.id}\">"+I18n.t(x.language) + "</a>"
    end
    array.join(I18n.t("lang_separator"))
  end

  def language_label(language)
    css_class = "post__language"
    label = ""
    case language
    when "pl"
      css_class << " post__language--pl"
      label = "波"
    when "en"
      css_class << " post__language--en"
      label = "英"
    when "zh"
      css_class << " post__language--zh"
      label = "中"
    when "zh-hans"
      css_class << " post__language--zh"
      label = "简"
    when "zh-hant"
      css_class << " post__language--zh"
      label = "繁"
    else
      label = "外"
    end
    content_tag :div, label, :class => css_class
  end
end
