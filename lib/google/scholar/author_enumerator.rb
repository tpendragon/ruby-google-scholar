require 'enumerator'
module Google
  module Scholar
    class AuthorEnumerator
      include Enumerable
      def initialize(scraper)
        @scraper = scraper
        @documents = scraper.documents
        self
      end
      def each
        current_document = @documents.first
        i = 1
        while(current_document)
          current_document.authors.each {|author| yield(author)}
          if(@documents.length > i)
            current_document = @documents[i]
          else
            if(@scraper.has_more_pages?)
              @scraper.load_next_page
              @documents = @scraper.documents
              current_document = @documents[i]
            else
              current_document = nil
            end
          end
          i += 1
        end
      end
    end
  end
end
