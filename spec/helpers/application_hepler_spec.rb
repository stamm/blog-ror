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
end