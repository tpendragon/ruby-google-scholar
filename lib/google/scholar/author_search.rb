module Google
  module Scholar
    class AuthorSearch < Google::Scholar::Base
      def authors
        return unless @scraper.documents.first.kind_of?(Google::Scholar::AuthorsDocument)
        @authors ||= Google::Scholar::AuthorEnumerator.new(@scraper)
      end
    end
  end
end