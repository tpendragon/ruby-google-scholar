require 'spec_helper'

describe Google::Scholar::AuthorEnumerator do
  subject {Google::Scholar::AuthorEnumerator}
  describe ".to_a (through .each)" do
    context "when the document does not have another page" do
      it "should return all the entries from the first document" do
        doc = Google::Scholar::AuthorsDocument.new(authors_document_with_next)
        doc.stub(:has_next_page?).and_return(false)
        Google::Scholar::Scraper.should_receive(:load_url).with(Google::Scholar.author_search_url("test")).and_return(doc)
        @enumerator = subject.new(Google::Scholar::Scraper.new(Google::Scholar.author_search_url("test")))
        @enumerator.to_a.should == doc.authors
      end
    end
    context "when the document has another page" do
      it "should return all entries from the second document as well" do
        doc1 = Google::Scholar::AuthorsDocument.new(authors_document_with_next)
        doc1.stub(:has_next_page?).and_return(false)
        doc2 = Google::Scholar::AuthorsDocument.new(authors_document_with_next)
        doc2.stub(:has_next_page?).and_return(true)
        doc2.stub(:next_page_url).and_return("bla")
        Google::Scholar::Scraper.should_receive(:load_url).with(Google::Scholar.author_search_url("test")).and_return(doc2)
        Google::Scholar::Scraper.should_receive(:load_url).with("bla").and_return(doc1)
        @enumerator = subject.new(Google::Scholar::Scraper.new(Google::Scholar.author_search_url("test")))
        @enumerator.map{|x| x.name}.should == doc1.authors.map{|x| x.name}.concat(doc2.authors.map{|x| x.name})
      end
    end
  end
end

def authors_document_with_next
  @author_document_with_next ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_result_page_has_next.htm")).read)
end