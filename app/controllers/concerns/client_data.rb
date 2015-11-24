module ClientData
  extend ActiveSupport::Concern

  def browser_name
    metadata = browser.name + " "
    metadata << browser.full_version.to_s
    metadata << " mobile" if browser.mobile?
    metadata << " tablet" if browser.tablet?
    metadata << " bot" if browser.bot?
    metadata << " #{browser.platform}"
    return metadata
  end
end
