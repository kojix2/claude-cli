module Claude
  class Anthropic
    class ContentBlock
      property type : String
      property text : String?
      property source : Hash(String, String)?

      def initialize(@type : String, @text : String? = nil, @source : Hash(String, String)? = nil)
      end
    end

    class Message
      property role : String
      property content : Array(ContentBlock)

      def initialize(@role : String, @content : Array(ContentBlock))
      end
    end
  end
end
