# DigitalBiblePlatform

A ruby wrapper for the [Digital Bible Platform](http://www.digitalbibleplatform.com/docs/)

## Installation

Add this line to your application's Gemfile:

    gem 'digital_bible_platform'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install digital_bible_platform

## Usage

#### Get an [API Key](http://www.digitalbibleplatform.com/dev/signup/) 
#### Initialize a Client  
```ruby
@client = DigitalBiblePlatform::Client.new(<your-api-key>)
```

#### Get a list of the books of the Bible  
You will need the short\_code (dam\_id)  
```ruby
books = @client.books
```

#### Get the media link for a book of the bible
```ruby
books = @client.url\_for('2Tim', 4)
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/digital_bible_platform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
