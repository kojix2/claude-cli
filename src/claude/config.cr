module Claude
  class Config
    def self.auth_key : String
      ENV.fetch("ANTHROPIC_API_KEY") {
        raise ApiKeyError.new
      }
    end

    def self.user_agent : String
      ENV["ANTHROPIC_USER_AGENT"]? || "claude-cli/#{VERSION}"
    end
  end
end
