require 'rails_helper'

RSpec.describe "Reader subscribes for the Moroz Newsletter" do
  fixtures :subscription_countries

  it "creates a new subscription" do
    visit new_subscription_path
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "E-mail:", with: "john.doe@example.com"
    select "English", from: "Language"
    select "America", from: "Country"
    click_on "Subscribe"
  end
end
