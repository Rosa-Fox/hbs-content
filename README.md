# Hbs::Content

A gem that provides a nice simple interface for getting Happy Bear Software
content. Currently backed by contentful, but there's no reason we can't change
out the underlying data provider.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hbs-content', '0.3.0', git: 'git@github.com:happybearsoftware/hbs-content.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hbs-content

## Usage

Configure the gem to use contentful (if you're using
Rails, you probably want this in an initializer):

```ruby
HbsContent.configure(:contentful, 
  access_token: 'my access token',
  space: 'space id'
)

```

Get all people in Happy Bear Software:

```
people = HbsContent::Person.all
```

Iterate over them and show some info (see `lib/hbs_content/person.rb` for a
full list of fields on `Person`).

```ruby
people.each do |person|
  puts "#{person.full_name}, currently located in #{person.short_location}"
end

```

`person.profile_photo_url` returns a `ContentfulImageUrl` which provides a fluent interface for building up an image URL.

Get the image URL as it is like this:

```ruby
person.profile_photo_url.to_s
#=> '//images.something.com/something.jpg'

```

[Contentful allows for URL-based image manipulation.](https://www.contentful.com/blog/2014/08/14/do-more-with-images-on-contentful-platform/) Add a width and a height to the image URL like this:

```ruby
person.profile_photo_url.width(100).height(100).to_s
#=> '//images.something.com/something.jpg?w=100&h=100'

```

Add quality value like this:

```ruby
person.profile_photo_url.quality(3).to_s
#=> '//images.something.com/something.jpg?q=3'
```

For more options, see the above linked blog post and the class definition of `ContentfulImageUrl`.



