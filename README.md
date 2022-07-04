# HotwireDatatables

Enhancing your Hotwire-based Rails app with declarative datatables.
Keeps you code DRY and readable and gives you features like broadcasting
changes, infinite scrolling, lazy loading as well as full control over
rendering and styling of your content.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hotwire_datatables'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hotwire_datatables

## Usage

### Declare your table

```ruby
class BooksTable < HotwireDatatables::Table
  query_adapter :active_record # it's the default, usually unnecessary, just for completeness
  pagination_adapter :pagy # can be extended later for custom pagination

  # define the query for the underlying data
  # receives the base collection and params that the controller passes in to the constructor
  query do |base, _params|
    base.joins(:author)
  end
  
  # The base query is supplied by the controller
  # and is enhanced here for suitability to the needs of the table
  query ->(records, _params) do
    records.joins(:authors) # for sorting
           .includes(:authors)
           .distinct
  end

  column :title do
    sortable
  end

  column :author_names do
    sortable
    sort_expression 'authors.name'
    value { |book| book.authors.pluck(:name).join(', ') }
  end
end
```

### Instantiate your table from your controller

```ruby
class BooksController < ApplicationController
  def index
    books = Book.all
    @books_table = BooksTable.new(request, books)
  end
end
```

### Render it

#### `index.html.erb`

```rhtml
<h1>Books</h1>

<%= render @books_table %>
```

### Further reading

You can generate documentation using `yard` which will render to the `doc/` directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/milgner/hotwire_datatables.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
