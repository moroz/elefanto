module ImagesHelper
  def image_asset_tag(image)
    img = content_tag 'img', nil, class: 'img-responsive', src: image.asset.url, alt: image.title, id: dom_id(image)
    link_to img, image.asset.url, target: '_blank', title: t('image.enlarge_html')
  end
end
