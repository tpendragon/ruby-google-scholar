require 'spec_helper'

describe Google::Scholar do
  describe ".google_root" do
    it "should return scholar.google.com" do
      Google::Scholar.google_root.should == "scholar.google.com"
    end
  end
  describe ".author_search_url" do
    context "when given an author name" do
      it "should give an appropriate url" do
        Google::Scholar.author_search_url("test").should == 'http://scholar.google.com/citations?view_op=search_authors&hl=en&mauthors=author%3A%22test%22'
      end
    end
    context "when given an author name with spaces" do
      it "should perform escaping" do
        Google::Scholar.author_search_url("testing this").should == 'http://scholar.google.com/citations?view_op=search_authors&hl=en&mauthors=author%3A%22testing+this%22'
      end
    end
  end
end
