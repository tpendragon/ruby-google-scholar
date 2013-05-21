require 'spec_helper'

describe Google::Scholar::AuthorSearch do
  subject {Google::Scholar::AuthorSearch}
  before(:each) do
    Google::Scholar::Scraper.should_receive(:open).and_return(author_result.to_html)
    @doc = subject.new(Google::Scholar.author_search_url("test"))
  end
  it "should initialize" do
    @doc
  end
  describe ".authors" do
    it "should return an author enumerator" do
      @doc.authors.should be_kind_of Google::Scholar::AuthorEnumerator
    end
  end
end
def author_result
  @author_result ||= Nokogiri::HTML::DocumentFragment.parse(File.open(File.join(FIXTURE_DIR,"author_result_page.htm")).read)
end