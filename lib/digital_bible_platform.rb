require "digital_bible_platform/version"
require "digital_bible_platform/dam_id"
require "typhoeus"
require "hashie"
require "oj"

module DigitalBiblePlatform
  class Client
    attr_reader :api_key   #'fd82d19821647fa4829c7ca160b82e6f'

    def initialize(api_key, defaults={})
      @api_key = api_key
      @defaults = {
        # API Defaults
        protocol:       'http', 
        audio_encoding: 'mp3',
        callback:       false,

        # Media Defaults
        language:   "English",
        version:    :esv,
        collection: :complete,
        drama:      :drama,
        media:      :audio,
      }.merge(defaults)
    end

    
    def url_for(book_short_name, chapter=1, overrides={})      
      response = connect!('/audio/path', {
        dam_id: DamId.full( @defaults.merge(overrides.merge({book:book_short_name}) )),
        book_id:    book_short_name,
        chapter_id: chapter,
      })
      file = response.find {|book| book.book_id==book_short_name}.path
      "#{base_url}/#{file}"
    end
    
    def books(overrides={})
      options = @defaults.merge(overrides)
      connect!('/library/book', { dam_id: DamId.partial(options) })
    end
    
  private
  
    def connect!(path, options={})
      request_body = {key:@api_key, v:'2'}.merge(options)
      request_body.merge!({reply:'jsonp',callback:@defaults[:callback]}) if @defaults[:callback]
      response = Typhoeus.get("http://dbt.io#{path}", params:request_body, followlocation: true)
      reply = Oj.load( response.body )
      
      case reply
        when Hash  then Hashie::Mash.new(reply)
        when Array then reply.map {|hash| Hashie::Mash.new(hash)}
      end
    end
    
    def base_url
      @cdns ||= connect!('/audio/location')
      cdn = @cdns.sort_by(&:priority).first {|_cdn| _cdn.protocal==@defaults[:protocal]}
      "#{cdn.protocol}://#{cdn.server}#{cdn.root_path}"
    end
  end
end


# DEV
@client = DigitalBiblePlatform::Client.new('fd82d19821647fa4829c7ca160b82e6f')