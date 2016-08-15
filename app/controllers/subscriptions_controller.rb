class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
    @countries = SubscriptionCountry.all
  end
end
