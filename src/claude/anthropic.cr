require "json"
require "crest"
require "../ext/crest"
require "./exceptions"
require "./config"
require "./version"

module Claude
  class Anthropic
    API_URL_BASE = "https://api.anthropic.com/v1"

    getter :api_url_base

    def initialize
      @api_url_base = API_URL_BASE
    end

    private def api_url_messages
      "#{api_url_base}/messages"
    end

    private def http_header_base
      {
        "x-api-key"         => auth_key,
        "anthropic-version" => "2023-06-01",
      }
    end

    def messages(
      model,
      messages,
      system_message = nil,
      max_tokens = 1024,
      metadata = nil,
      sto_sequence = nil,
      stream = false,
      temperature = nil,
      top_p = nil,
      top_k = nil
    )
      params = {
        "model"      => model,
        "messages"   => JSON.parse(messages),
        "system"     => system_message,
        "max_tokens" => max_tokens,
      }.compact

      response = Crest.post(
        api_url_messages,
        form: params,
        headers: http_header_base,
        json: true
      )

      parse_response(response)
    end

    private def parse_response(response)
      body = response.body
      JSON.parse(body)["content"][0]["text"]
    end

    private def auth_key
      Claude::Config.auth_key
    end
  end
end
