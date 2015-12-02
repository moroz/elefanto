class PagesController < ApplicationController
  def home
    @title = "Elefanto — " + I18n.t("homepage")
  end

  def about
    @title = "Elefanto — " + I18n.t("about")
    @mobile = browser.mobile?
  end

  def faq
    @title = "Elefanto — " + I18n.t("faq")
  end

  def schedule
    @title = "Plan lekcji"
  end
end
