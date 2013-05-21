module Google
  module Scholar
    class Base
      attr_accessor :scraper
      def initialize(url)
        @scraper = Google::Scholar::Scraper.new(url)
        self
      end
      def self.search_author(author)
        url = Google::Scholar.author_search_url(author)
        self.new(url)
      end
      def authors
        return unless @scraper.documents.first.kind_of?(Google::Scholar::AuthorsDocument)
        @authors ||= Google::Scholar::AuthorEnumerator.new(@scraper)
      end
    end
  end
end