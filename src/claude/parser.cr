require "option_parser"
require "./options"
require "./anthropic"

module Claude
  class Parser < OptionParser
    getter opt : Options
    property help_message : String

    macro _on_debug_
      on("-d", "--debug", "Show backtrace on error") do
        ClaudeError.debug = true
      end
    end

    macro _on_help_
      on("-h", "--help", "Show this help") do
        opt.action = Action::Help
        self.help_message = self.to_s
      end
    end

    def initialize
      super()
      @opt = Options.new
      @help_message = ""

      self.banner = <<-BANNER

      Program: Claude CLI (Simple command line tool for Anthropic)
      Version: #{Claude::VERSION}
      Source:  https://github.com/kojix2/claude-cli

      Usage: claude [options] <file>
      BANNER

      on("-M", "--model MODEL", "Model to use (default: #{opt.model})") do |model|
        opt.model = model
      end

      on("-m", "--message MESSAGE", "Message") do |message|
        opt.message = message
      end

      on("-f", "--file FILE", "File to use") do |fname|
        opt.files << fname
      end

      _on_debug_

      on("-v", "--version", "Show version") do
        opt.action = Action::Version
      end

      _on_help_

      invalid_option do |flag|
        STDERR.puts "[claude-cli] ERROR: #{flag} is not a valid option."
        STDERR.puts self
        exit(1)
      end
    end

    def parse(args)
      super
      opt
    end
  end
end
