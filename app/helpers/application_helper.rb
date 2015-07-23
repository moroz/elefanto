module ApplicationHelper
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
end
