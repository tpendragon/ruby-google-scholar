require 'nokogiri'
require 'open-uri'
module Google
  module Scholar
    class AuthorsProfileDocument < Document
      def articles(force=false)
        return @citations if @citations && !force
        @citations = []
        self.css(".cit-table tr.item").each {|row| @citations << Google::Scholar::Article.new(row)}
        return @citations
      end
    end
  end
end