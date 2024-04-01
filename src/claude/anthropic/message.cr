module Claude
  class Anthropic
    class ContentBlock
      include JSON::Serializable

      property type : String
      property text : String?
      property source : Hash(String, String)?

      def initialize(@type : String, @text : String? = nil, @source : Hash(String, String)? = nil)
      end
    end

    class Message
      include JSON::Serializable

      property role : String
      property content : String | Array(ContentBlock)

      def initialize(@role : String, @content : String | Array(ContentBlock))
      end
    end
  end
end
