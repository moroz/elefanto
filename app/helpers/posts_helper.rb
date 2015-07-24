module PostsHelper
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
end
