require 'spec_helper'

describe ApplicationHelper do

  describe "title" do
    it "should include the page title" do
      @title = "foo"
      expect(title).to match(/foo/)
    end

    it "should include the base title" do
      @title = "foo"
      expect(title).to match(/^Zagirov/)
    end
  end

  it "gravatar" do
    img = gravatar_for('stammru@gmail.com', 'stamm')
    should_img = image_tag("https://secure.gravatar.com/avatar/cf206824414647c8613541f09ec34176", alt: "stamm", class: "gravatar")
    expect(img).to eq(should_img)
  end
end