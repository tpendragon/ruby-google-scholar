module Google
  module Scholar
    class ArticleSummary
      def initialize(doc)
        @document = doc
      end
      def title
        @title ||= @document.css("#col-title a:first").text
      end
      def authors
        @authors ||= @document.css("#col-title span:first").text
      end
      def publisher
        @publisher ||= @document.css("#col-title span:last").text
      end
      def citations
        @citations ||= @document.css("#col-citedby a:first").text.to_i
      end
      def year
        @year ||= @document.css("#col-year").text.to_i
      end
      def full_article_url
        @full_article_url ||= "#{Google::Scholar.google_url}#{@document.css("#col-title a:first").attr("href").text}"
      end
    end
  end
end
