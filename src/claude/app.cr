require "term-spinner"
require "./parser"
require "./anthropic"
require "./exceptions"

module Claude
  class App
    getter parser : Parser
    getter option : Options

    def initialize
      @parser = Parser.new
      @option = parser.parse(ARGV)
    end

    def run
      case option.action
      when Action::Message
        message
      when Action::Version
        print_version
      when Action::Help
        print_help
      else
        raise "Invalid action: #{option.action}"
      end
    rescue ex
      error_message = "[claude-cli] ERROR: #{ex.class} #{ex.message}"
      error_message += "\n#{ex.response}" if ex.is_a?(Crest::RequestFailed)
      error_message += "\n#{ex.backtrace.join("\n")}" if ClaudeError.debug
      STDERR.puts error_message
      exit(1)
    end

    def message
      client = Anthropic.new
      messages = [
        Anthropic::Message.new(role: "user", content: option.message),
      ].to_json

      result = ""

      with_spinner do
        result = client.messages(
          model: option.model,
          messages: messages
        )
      end

      puts result
    end

    private def with_spinner(&block)
      spinner = Term::Spinner.new(clear: true)
      spinner.run do
        block.call
      end
    end

    def print_version
      puts Claude::VERSION
    end

    def print_help
      puts parser.help_message
    end
  end
end
