require 'spec_helper'

describe Google::Scholar::Scraper do
  describe ".initialize" do
    it "should require a url" do
      expect{Google::Scholar::Scraper.new}.to raise_error
    end
    it "should validate an http url" do
      expect{Google::Scholar::Scraper.new("bla@bla.org")}.to raise_error
      expect{Google::Scholar::Scraper.new("http://scholar.google.com")}.not_to raise_error
      expect{Google::Scholar::Scraper.new("ftp://scholar.google.com")}.to raise_error
    end
    it "should load up a nokogiri document" do
      Nokogiri::HTML::Document.should_receive(:parse)
      Google::Scholar::Scraper.should_receive(:open).with("http://scholar.google.com")
      Google::Scholar::Scraper.new("http://scholar.google.com")
    end
  end
  describe ".valid?" do
    it "should forward its valid method to its document" do
      doc = double("authors document")
      doc.should_receive(:valid?).and_return(true)
      Google::Scholar::AuthorsDocument.should_receive(:new).and_return(doc)
      Google::Scholar::Scraper.should_receive(:open)
      r = Google::Scholar::Scraper.new(Google::Scholar.author_search_url("test"))
      r.valid?
    end
  end
  describe ".has_more_pages?" do
    it "should forward it to the last document it has" do
      doc = double("authors document")
      doc.should_receive(:has_next_page?)
      Google::Scholar::AuthorsDocument.should_receive(:new).and_return(doc)
      Google::Scholar::Scraper.should_receive(:open)
      r = Google::Scholar::Scraper.new(Google::Scholar.author_search_url("test"))
      r.has_more_pages?
    end
  end
end