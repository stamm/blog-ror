require 'spec_helper'

describe ApplicationHelper do

  describe "title" do
    it "should include the page title" do
      @title = "foo"
      title.should =~ /foo/
    end

    it "should include the base title" do
      @title = "foo"
      title.should =~ /^Zagirov/
    end
  end

  it "gravatar" do
    img = gravatar_for('stammru@gmail.com', 'stamm')
    img.should == image_tag("https://secure.gravatar.com/avatar/cf206824414647c8613541f09ec34176", alt: "stamm", class: "gravatar")
  end
end