class PagesController < ApplicationController
  def home
    @title = t("titles.homepage")
  end

  def about
    @title = t("titles.about")
    @mobile = browser.mobile?
  end
end
