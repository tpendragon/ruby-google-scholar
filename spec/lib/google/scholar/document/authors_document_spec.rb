require 'spec_helper'

describe Google::Scholar::AuthorsDocument do
  subject {Google::Scholar::AuthorsDocument}
  describe "initialization" do
    it "should accept a nokogiri document" do
      expect{subject.new(nokogiri_document)}.not_to raise_error
    end
  end
  describe ".valid" do
    context "if the page says Authors" do
      before(:each) do
        @doc = nokogiri_document("Authors")
      end
      it "should be valid" do
        doc = subject.new(@doc)
        doc.should be_valid
      end
    end
    context "if the page also says it didn't match anything" do
      before(:each) do
        @doc = nokogiri_document("Authors didn't match any user profiles.")
      end
      it "should be invalid" do
        doc = subject.new(@doc)
        doc.should_not be_valid
      end
    end
  end
  describe ".has_next_page?" do
    context "when there is a next page" do
      before(:each) do
        @doc = subject.new(authors_document_with_next)
      end
      it "should have a next page" do
        @doc.should have_next_page
      end
    end
    context "when there is no next page" do
      before(:each) do
        @doc = subject.new(authors_document)
      end
      it "should not have a next page" do
        @doc.should_not have_next_page
      end
    end
  end
  describe ".next_page_url" do
    context "when there is a next page" do
      before(:each) do
        @doc = subject.new(authors_document_with_next)
      end
      it "should return the url for the next page" do
        @doc.next_page_url.should == "http://scholar.google.com/citations?view_op=search_authors&hl=en&mauthors=author:%22Johnson%22&after_author=6jwJANrc__8J&astart=10"
      end
    end
    context "when there isn't a next page" do
      before(:each) do
        @doc = subject.new(authors_document)
      end
      it "should return nil" do
        @doc.next_page_url.should be_nil
      end
    end
  end
  describe ".authors" do
    before(:each) do
      @auth_doc = subject.new(authors_document)
    end
    it "should return a list of authors" do
      @auth_doc.authors.length.should == 10
    end
    it "should return author objects" do
      @auth_doc.authors.first.should be_kind_of Google::Scholar::Author
    end
    it "should parse the objects" do
      @auth_doc.authors.first.name.should == "David S. Johnson"
    end
  end
  describe ".last_author" do
    before(:each) do
      @auth_doc = subject.new(authors_document)
    end
    it "should return the last author" do
      @auth_doc.last_author.id.should == "aLwIpzYAAAAJ"
    end
  end
end

def nokogiri_document(string=nil)
  return @nokogiri_document if @nokogiri_document && string.nil?
  @read_object = double("document")
  string ||= "Authors didn't match any user profiles."
  @read_object.stub(:read).and_return(string)
  self.should_receive(:open).and_return(@read_object)
  @nokogiri_document = Nokogiri::HTML(open("http://test.org"))
end
def authors_document
  @author_document ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_result_page.htm")).read)
end
def authors_document_with_next
  @author_document_with_next ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_result_page_has_next.htm")).read)
end