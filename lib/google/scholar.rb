require "google/scholar/version"
require "google/scholar/base"
require "google/scholar/scraper"
require "google/scholar/document"
require "google/scholar/author"
require "google/scholar/author_enumerator"
require "google/scholar/article_summary"
require "google/scholar/article_enumerator"
require "google/scholar/document/authors_document"
require "google/scholar/document/authors_profile_document"
require 'cgi'
module Google
  module Scholar
    def self.google_root
      "scholar.google.com"
    end
    def self.http_scheme
      "http://"
    end
    def self.google_url
      "#{self.http_scheme}#{self.google_root}"
    end
    def self.author_search_url(author)
      "#{self.http_scheme}#{self.google_root}/citations?view_op=search_authors&hl=en&mauthors=#{::CGI::escape("author:\"#{author}\"")}"
    end
  end
end
