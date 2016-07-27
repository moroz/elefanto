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

  def browser_string
    @browser_string = [@browser.name, @browser.full_version.to_s, @browser.device.name, bot?, @browser.platform].reject(&:blank?).join(' ') 
  end

  def log
    set_location
    Visit.create(:post_id => @post_id, :ip => @ip, :browser => browser_string, :city => @city, :country => @country)
  end
end