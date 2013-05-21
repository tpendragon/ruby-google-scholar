require 'spec_helper'

describe Google::Scholar::AuthorsProfileDocument do
  subject {Google::Scholar::AuthorsProfileDocument.new(author_profile_page)}
  it "should have a valid subject" do
    subject
  end
  describe ".has_next_page?" do
    context "if the document has a next page" do
      it "should return true" do
        subject.should have_next_page
      end
    end
    context "if the document doesn't have a next page" do
      let(:author_profile_page) {Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_profile_page.htm")).read.to_s.gsub('Next',''))}
      it "should return false" do
        subject.should_not have_next_page
      end
    end
  end
  describe ".next_page_url" do
    it "should return the url for the next page" do
      subject.next_page_url.should == "http://scholar.google.com/citations?hl=en&user=M7uPknsAAAAJ&view_op=list_works&cstart=20"
    end
  end
  describe ".articles" do
    it "should return the articles for this page" do
      subject.articles.length.should == 20
    end
    it "should return article summary objects" do
      subject.articles.first.should be_kind_of Google::Scholar::ArticleSummary
    end
    it "should have the right titles" do
      subject.articles.first.title.should == "Weblogs and the 'middle space'for learning"
    end
  end
end
def author_profile_page
  @author_profile ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_profile_page.htm")).read)
end