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
        Google::Scholar::AuthorSearch.new(url)
      end
    end
  end
end