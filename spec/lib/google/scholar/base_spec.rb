require 'spec_helper'

describe Google::Scholar::Base do
  subject {Google::Scholar::Base}
  describe "#search_author" do
    it "should initialize with the search author string" do
      Google::Scholar::Scraper.should_receive(:new).with(Google::Scholar.author_search_url("test"))
      subject.search_author("test")
    end
  end
end