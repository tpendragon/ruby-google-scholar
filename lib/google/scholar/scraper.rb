require 'nokogiri'
require 'open-uri'
module Google
  module Scholar
    class Scraper
      attr_accessor :documents
      def initialize(url,initial_document=nil)
        @documents = []
        @documents << initial_document if initial_document
        @documents << self.class.load_url(url) if url
        self
      end
      def self.class_lookup(url="")
        arguments = url.split("?")
        arguments = arguments[1].split("&") if arguments.length > 1
        if(arguments.include?("view_op=search_authors"))
          return Google::Scholar::AuthorsDocument
        end
        if(arguments.any?{|x| x.include?("user=")})
          return Google::Scholar::AuthorsProfileDocument
        end
        return Google::Scholar::Document
      end
      def valid?
        @documents.each do |document|
          return false unless document.valid?
        end
        return true
      end
      def load_next_page
        return unless self.has_more_pages?
        @documents << self.class.load_url(@documents.last.next_page_url)
      end
      def authors
        @authors ||= Google::Scholar::AuthorEnumerator.new(self)
      end
      def self.search_author(author)
        url = Google::Scholar.author_search_url(author)
        self.new(url)
      end
      def self.load_url(url)
        uri = URI(url)
        raise "Invalid scheme for #{url}" if uri.scheme.nil? || !%w{http https}.any?{|scheme| uri.scheme == scheme}
        return class_lookup(url).new(Nokogiri::HTML(open(url)))
      end
      def has_more_pages?
        @documents.last.has_next_page?
      end
    end
  end
end
