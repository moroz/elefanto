class PagesController < ApplicationController
  def home
    @title = t("titles.homepage")
  end

  def about
    @title = t("titles.about")
  end
end
