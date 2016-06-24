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

  def image_from_s3(title)
    image = Image.find_by(title: title)
    if image
      image_tag image.url, class: 'img-responsive', alt: title
    else
      link_to "[Image:#{title}]", new_image_url(title: title)
    end
  end
end
