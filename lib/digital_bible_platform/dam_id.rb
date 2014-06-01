require 'iso-639'
module DigitalBiblePlatform
  
  class DamId
    class << self
    
      # Example ENGESV
      def partial(options={})
        [ (Codes.language    options[:language]    ),
          (Codes.version     options[:version]     ),
        ].join('').upcase
      end
    
      # Example ENGESVN2DA
      def full(options={})
        collection = if options[:book]
          Codes.collection_from_book options[:book]
        else
          Codes.collection  options[:collection]
        end
        
        [ (Codes.language    options[:language]    ),
          (Codes.version     options[:version]     ),
          (collection                              ),
          (Codes.drama       options[:drama]       ),
          (Codes.media       options[:media]       ),
        ].join('').upcase
      end
    end

    # http://www.digitalbibleplatform.com/docs/core-concepts/ 
    class Codes
      class << self
        def language(name)
          lang   = ISO_639.find(name.to_s.downcase)
          lang ||= ISO_639.find_by_english_name(name.to_s.capitalize)
          raise ArgumentError.new("#{name} Not recognized as a language") unless lang
          lang.alpha3_bibliographic.upcase
        end
    
        def version(type)
          type.upcase.to_s
        end

        def collection(type)
          COLLECTIONS[type.to_sym]
        end
        
        def collection_from_book(book_short_name)
          return COLLECTIONS[:old_testament] if OLD_TESTAMENT_SHORT_NAMES.include? book_short_name
          return COLLECTIONS[:new_testament] if NEW_TESTAMENT_SHORT_NAMES.include? book_short_name
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
      
      OLD_TESTAMENT = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Solomon", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"] 
      NEW_TESTAMENT = ["Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
      
      OLD_TESTAMENT_SHORT_NAMES = ["Gen", "Exod", "Lev", "Num", "Deut", "Josh", "Judg", "Ruth", "1Sam", "2Sam", "1Kgs", "2Kgs", "1Chr", "2Chr", "Ezra", "Neh", "Esth", "Job", "Ps", "Prov", "Eccl", "Song", "Isa", "Jer", "Lam", "Ezek", "Dan", "Hos", "Joel", "Amos", "Obad", "Jonah", "Mic", "Nah", "Hab", "Zeph", "Hag", "Zech", "Mal"] 
      NEW_TESTAMENT_SHORT_NAMES = ["Matt", "Mark", "Luke", "John", "Acts", "Rom", "1Cor", "2Cor", "Gal", "Eph", "Phil", "Col", "1Thess", "2Thess", "1Tim", "2Tim", "Titus", "Phlm", "Heb", "Jas", "1Pet", "2Pet", "1John", "2John", "3John", "Jude", "Rev"]
      
    end
  end
end