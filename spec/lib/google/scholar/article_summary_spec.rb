require 'spec_helper'

describe Google::Scholar::ArticleSummary do
  subject {Google::Scholar::ArticleSummary.new(doc)}
  it "should be a valid subject" do
    subject
  end
  describe ".title" do
    it "should return the title" do
      subject.title.should == "Weblogs and the 'middle space'for learning"
    end
  end
  describe ".authors" do
    it "should return the authors" do
      subject.authors.should == "AM Deitering, S Huston"
    end
  end
  describe ".publisher" do
    it "should return the publication" do
      subject.publisher.should == "Academic Exchange Quarterly 8 (4), 273-278"
    end
  end
  describe ".citations" do
    it "should return the number of citations" do
      subject.citations.should == 25
    end
  end
  describe ".year" do
    it "should return the year it was published" do
      subject.year.should == 2004
    end
  end
  describe ".full_article_url" do
    it "should return the url for the full article" do
      subject.full_article_url.should == 'http://scholar.google.com/citations?view_op=view_citation&hl=en&user=M7uPknsAAAAJ&pagesize=100&citation_for_view=M7uPknsAAAAJ:kNdYIx-mwKoC'
    end
  end
end
def doc
  @doc ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"article_part.htm")).read)
end