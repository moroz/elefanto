module PostsHelper
  def do_formatting(str, textile_enabled)
    str.gsub! /<!--(.*?)-->(\n|\r\n|\n\r)/i, ''
    str.gsub! /<br\s*\/*>(\n|\r\n|\n\r)/, "\n"
    str.gsub!(/\[\[Image\:(\w+)\]\]/) { |x| image_from_s3($1) }
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
    s = str.gsub(/'{3}([^']+)'{3}/, '<strong>\1</strong>')
    s = s.gsub(/'{2}([^']+)'{2}/, '<em>\1</em>')
    s = simple_format(s)
    return s
  end

  def languages(lang_versions)
    array = lang_versions.map do |x|
      "<a href=\"#{post_path(x)}\">" + I18n.t(x.language) + "</a>"
    end
    array.join(I18n.t("separator"))
  end

  def category_list(categories)
    array = categories.map do |x|
      "<a href=\"#{category_path(x)}\">#{x.name}</a>"
    end
    array.join(I18n.t("separator"))
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
