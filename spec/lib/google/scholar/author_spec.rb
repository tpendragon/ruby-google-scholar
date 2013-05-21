require 'spec_helper'

describe Google::Scholar::Author do
  subject {Google::Scholar::Author}
  describe "initialization" do
    it "should require a document" do
      expect{subject.new}.to raise_error
    end
    it "should accept a document" do
      expect{subject.new(test_author_document)}.not_to raise_error
    end
  end
  describe "attributes" do
    subject {Google::Scholar::Author.new(test_author_document)}
    describe ".name" do
      it "should return the author name" do
        subject.name.should == "Test Author"
      end
    end
    describe ".citation_count" do
      it "should return the citation count" do
        subject.citation_count.should == 3020
      end
    end
    describe ".author_url" do
      it "should return the full author url" do
        subject.author_url.should == "#{Google::Scholar.google_url}/citations?user=XXXXXXX&hl=en&pagesize=100"
      end
    end
    describe ".id" do
      it "should return the author id" do
        subject.id.should == "XXXXXXX"
      end
    end
    describe ".full_profile" do
      before(:each) do
        Google::Scholar::Scraper.should_receive(:open).and_return(author_profile_page.to_html)
      end
      it "should return a nokogiri instance for the full profile" do
        subject.full_profile
      end
    end
    describe "profile functions" do
      before(:each) do
        Google::Scholar::Scraper.should_receive(:open).and_return(author_profile_page.to_html)
      end
      describe ".citations" do
        it "should return the number of citations" do
          subject.citations.should == 59
        end
      end
      describe ".articles" do
        it "should return all the articles via an enumerator" do
          subject.articles.should be_kind_of Google::Scholar::ArticleEnumerator
        end
      end
    end
  end
end

def test_author_document
  @test_author_document ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"single_author_page.htm")).read)
end
def author_profile_page
  @author_profile_page ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_profile_page.htm")).read)
end