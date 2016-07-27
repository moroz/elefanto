class VisitLogger
  def initialize(ip:,browser:,location:,post_id:)
    @ip = ip
    @browser = browser
    @location = location
    @post_id = post_id
  end

  def set_location
    @city = @location.try(:city)
    @country = @location.try(:country)
  end

  def bot?
    "bot" if @browser.bot?
  end

  def device
    return "ipad" if @browser.device.ipad?
    return "iphone" if @browser.device.iphone?
    return "mobile" if @browser.device.mobile?
    return "tablet" if @browser.device.tablet?
    @browser.device.id
  end

  def browser_string
    @browser_string = [@browser.name, @browser.full_version, device, bot?, @browser.platform].reject(&:blank?).join(' ') 
  end

  def log
    set_location
    Visit.create(:post_id => @post_id, :ip => @ip, :browser => browser_string, :city => @city, :country => @country)
  end
end