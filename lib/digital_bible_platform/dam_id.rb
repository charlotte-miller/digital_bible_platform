require 'iso-639'

class DamId
  class << self
    
    # Example ENGESV
    def partial(options={})
      [ (Codes.language    options[:language]    ),
        (Codes.version     options[:version]     ),
      ].join('').upcase
    end
    
    def full(options={})
      [ (Codes.language    options[:language]    ),
        (Codes.version     options[:version]     ),
        (Codes.collection  options[:collection]  ),
        (Codes.drama       options[:drama]       ),
        (Codes.media       options[:media]       ),
      ].join('').upcase
    end
  end

  # http://www.digitalbibleplatform.com/docs/core-concepts/ 
  class Codes
    class << self
      def language(name)
        lang = ISO_639.find_by_english_name(name.capitalize)
        raise ArgumentError.new("#{name} Not recognized as a language") unless lang
        lang.alpha3_bibliographic.upcase
      end
    
      def version(type)
        type.upcase.to_s
      end

      def collection(type)
        COLLECTIONS[type.to_sym]
      end
    
      def drama(type)
        DRAMA_TYPES[type.to_sym]
      end
    
      def media(type)
        MEDIA_TYPES[type.to_sym]
      end
    end
  
    COLLECTIONS = {
      old_testament: "O", # Contains one or more books of the Old Testament.
      new_testament: "N", # Contains one or more books of the New Testament.
           complete: "C", # Contains books from both the Old and New Testament. (These volumes are used primarily for content downloads, and are not generally used by the actual reader applications).
              story: "S", # Contains content that is not organized by books and chapters.
            partial: "P", # Contains only partial content, such as a few chapters from one book of the Bible.
    }
  
    DRAMA_TYPES = {
          drama: 2, # Audio includes spoken text, music, and sound effects.
      non_drama: 1, # Audio includes only spoken text.
    }
  
    MEDIA_TYPES = {
       text: "ET", # Electronic Text
      audio: "DA", # Digital Audio
      video: "DV", # Digital Video
    }
  end
end