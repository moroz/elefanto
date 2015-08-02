class PagesController < ApplicationController
  def home
    @title = I18n.t("homepage")
  end

  def about
    @title = I18n.t("about")
  end

  def links
    @title = I18n.t("links")
  end
end
