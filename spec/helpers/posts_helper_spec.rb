require 'rails_helper'

RSpec.describe PostsHelper do
  describe "#language_label" do
    it "displays correct label for defined languages" do
      expect(helper.language_label("pl")).to match("pl\">波")
      expect(helper.language_label("zh")).to match("zh\">中")
      expect(helper.language_label("en")).to match("en\">英")
    end

    it "displays default label for undefined languages" do
      expect(helper.language_label("pt")).to match("post__language\">外")
    end
  end

  describe "#post_link" do
    before(:each) do
      blog_post = FactoryGirl.build_stubbed(:post, number: 108, title: "Test post")
      allow(Post).to receive(:find_by).and_return(blog_post)
    end

    it "displays link to correct post for defined languages" do
      expect(helper.post_link(108)).to eq("<a href=\"/posts/108-test-post\">108.</a>")
    end

    describe "#do_formatting" do
      it "returns post_link when given [[number]]" do
        expect(helper.do_formatting('[[108]]', true)).to match(helper.post_link(108))
      end
      it "returns post_link with title when given [[numbert]]" do
        expect(helper.do_formatting('[[108t]]', true)).to match(helper.post_link(108, with_title: true))
      end
    end
  end
end
