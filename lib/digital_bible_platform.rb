require "digital_bible_platform/version"
require "digital_bible_platform/dam_id"
require "typhoeus"

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

    
    # options[:version]
    # options[:verse]
    def find(book, chapter, overrides={})
      DamId.create @defaults.merge(overrides)
    end
    
    def books
      connect!('/library/book', { dam_id: DamId.partial(@defaults) })
    end
    
  private
  
    def connect!(path, options={})
      request_body = {key:@api_key, v:'2'}.merge(options)
      request_body.merge!({reply:'jsonp',callback:@defaults[:callback]}) if @defaults[:callback]
      response = Typhoeus.get("http://dbt.io#{path}", params:request_body, followlocation: true)
      response.body
    end
    
  end
end


# DEV
@client = DigitalBiblePlatform::Client.new('fd82d19821647fa4829c7ca160b82e6f')