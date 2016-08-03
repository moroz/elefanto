module ApplicationHelper
  def background
    images = ["background-sand.jpg", "background-spain.jpg",
      "background-night.jpg", "background-xian.jpg", "background-creatures.jpg", "background-tht.jpg", "background-gate.jpg",
      "background-buddha.jpg", "background-tatooine.jpg"]
    path = "url(/images/backgrounds/" + images.shuffle.first + ")"
  end

  def current_locale
    I18n.locale
  end

  def image_from_s3(slug)
    image = Image.find_by_param(slug)
    if image
      image_asset_tag image
    else
      link_to "[Image:#{slug}]", new_image_url(url: slug)
    end
  end
end
