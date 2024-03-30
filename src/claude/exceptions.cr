module Claude
  class ClaudeError < Exception
    class_property debug : Bool = false
  end

  class ApiKeyError < ClaudeError
    def initialize
      super <<-MSG
        ANTHROPIC_API_KEY is not set.
        MSG
    end
  end
end
