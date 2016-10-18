class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
    @countries = SubscriptionCountry.all
  end

  def create
    @action = SubscriptionCreator.new(params[:subscription])
    if @action.create
      redirect_to subscription_success_path
    else
      @subscription = @action.subscription
      render :new
    end
  end

  def success
  end
end
