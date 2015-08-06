class PagesController < ApplicationController
  def home
    @title = "Elefanto — " + I18n.t("homepage")
  end

  def about
    @title = "Elefanto — " + I18n.t("about")
  end

  def faq
    @title = "Elefanto — " + I18n.t("faq")
  end
end
