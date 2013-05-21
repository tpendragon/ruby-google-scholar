require 'spec_helper'

describe Google::Scholar::ArticleEnumerator do
  subject {Google::Scholar::ArticleEnumerator}
  describe ".to_a (through .each)" do
    context "when the document does not have another page" do
      it "should return all the entries from the first document" do
        doc = Google::Scholar::AuthorsProfileDocument.new(authors_profile_with_next)
        doc.stub(:has_next_page?).and_return(false)
        Google::Scholar::Scraper.should_not_receive(:load_url)
        @enumerator = subject.new(Google::Scholar::Scraper.new(nil,doc))
        @enumerator.to_a.should == doc.articles
      end
    end
    context "when the document has another page" do
      it "should return all entries from the second document as well" do
        doc1 = Google::Scholar::AuthorsProfileDocument.new(authors_profile_with_next)
        doc1.stub(:has_next_page?).and_return(false)
        doc2 = Google::Scholar::AuthorsProfileDocument.new(authors_profile_with_next)
        doc2.stub(:has_next_page?).and_return(true)
        doc2.stub(:next_page_url).and_return("bla")
        Google::Scholar::Scraper.should_receive(:load_url).with("bla").and_return(doc1)
        @enumerator = subject.new(Google::Scholar::Scraper.new(nil,doc2))
        @enumerator.map{|x| x.title}.should == doc1.articles.map{|x| x.title}.concat(doc2.articles.map{|x| x.title})
      end
    end
  end
end

def authors_profile_with_next
  @author_profile_with_next ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_profile_page.htm")).read)
end