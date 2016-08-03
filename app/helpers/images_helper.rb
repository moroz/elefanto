module ImagesHelper
  def image_asset_tag(image)
    content_tag 'img', nil, class: 'img-responsive', src: image.asset.url
  end
end
