# Google::Scholar

Google Scholar interface. Currently only works for Author searches.

## WARNINGS

This gem restricts its hits to Google Scholar as much as possible, but be forewarned that their page may
restrict your hits if it starts to hit it too much. There is no built in rate limiter to this gem.

## Installation

Add this line to your application's Gemfile:

    gem 'google-scholar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-scholar

## Usage

Run an author search:

```ruby
results = Google::Scholar::Base.search_author("author name")
```

Get authors (as an enumerator):

```ruby
results.authors
```

Get author's article summaries (as an enumerator):

```ruby
results.authors.first.articles
```

## Future Development

- Support for searching articles
- Support for full articles (what you get when you navigate to an article's full_article_url)
- Improved documentation
- Rate limiter?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
