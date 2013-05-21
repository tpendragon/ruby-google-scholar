module Google
  module Scholar
    class Document
      attr_reader :document
      def initialize(nokogiri_document)
        @document = nokogiri_document
      end
      def method_missing(meth, *args, &block)
        if(@document.respond_to?(meth))
          return @document.send(meth,*args,&block)
        else
          super
        end
      end
      def has_next_page?
        @document.css('.cit-dgb .cit-dark-link').each do |link|
          return true if link.content.include?("Next")
        end
        return false
      end
      def next_page_url
        return nil unless self.has_next_page?
        @document.css('.cit-dgb .cit-dark-link').each do |link|
          if(link.content.include?("Next"))
            return "#{Google::Scholar.google_url}#{link.attr("href")}"
          end
        end
      end
    end
  end
end
