require 'rails_helper'

RSpec.describe PostsHelper do
  describe "#language_label" do
    it "displays correct label for defined languages" do
      expect(helper.language_label("pl")).to match("pl\">波")
      expect(helper.language_label("zh-hans")).to match("zh\">简")
      expect(helper.language_label("en")).to match("en\">英")
    end

    it "displays default label for undefined languages" do
      expect(helper.language_label("pt")).to match("post__language\">外")
    end
  end
end