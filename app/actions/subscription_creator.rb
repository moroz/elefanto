class SubscriptionCreator
  def initialize(params)
    @subscription = Subscription.new
    @subscription.first_name = params[:first_name]
    @subscription.last_name = params[:last_name]
    @subscription.email = params[:email]
    @subscription.country = params[:country]
    @subscription.language = params[:language]
  end

  def create
    if @subscription.save
      true
    else
      @subscription
    end
  end

end
