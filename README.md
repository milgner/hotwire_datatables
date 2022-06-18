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
class BlogCommentsTable < HotwireDatatables::Table
  query_adapter :active_record # it's the default, usually unnecessary, just for completeness
  pagination_adapter :pagy # alternative: :infinite_scroll, can be extended of course for custom pagination

  # define the query for the underlying data
  # receives the base collection and params that the controller passes in to the constructor
  query do |base, _params|
    base.joins(:author)
  end

  # simple column from the associated model
  column :posted_at do
    orderable default: :desc
    # some standard formats like `date`, `timestamp` etc might be useful
    format_with {|posted_at, _comment| I18n.l(posted_at) }
  end

  # Show data from an associated model
  column :author do
    load_from Author.arel_table[:full_name]
  end

  # Basic filter using just a text input, case-insensitive by default
  filter :author, :text
  filter :posted_at, :time_range
end
```

### Instantiate your table from your controller

```ruby
class BlogCommentsController < ApplicationController
  before_action :load_blog_post
  
  def index
    @blog_comments_table = BlogCommentsTable.new(@blog_post.comments, params)
  end
  
  private
  
  def load_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id]
  end
end
```

### Render it

#### `index.html.erb`

```rhtml
<h1>Comments</h1>

<%= render @blog_comments_table %>
```

#### `index.turbo_stream.erb`

```rhtml
<%= turbo_stream.replace @blog_comments_table.dom_id, @blog_comments_table %>
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
