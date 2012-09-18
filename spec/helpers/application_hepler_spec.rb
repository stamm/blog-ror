require 'spec_helper'

describe ApplicationHelper do

  describe "title" do
    it "should include the page title" do
      title("foo").should =~ /foo/
    end

    it "should include the base title" do
      title("foo").should =~ /^Zagirov/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end
end