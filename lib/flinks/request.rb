require 'http'

require 'flinks/error'

module Flinks
  module Request

    # Performs a HTTP Get request
    #
    # @param path [String]
    # @param params [Hash]
    def get(path, params: {})
      request(:get, path, params: params)
    end

    # Performs a HTTP Post request
    #
    # @param path [String]
    # @param params [Hash]
    # @param body [Hash]
    def post(path, params: {}, body: {})
      request(:post, path, params: params, body: body)
    end

    # Performs a HTTP Patch request
    #
    # @param path [String]
    # @param params [Hash]
    # @param body [Hash]
    def patch(path, params: {}, body: {})
      request(:patch, path, params: params, body: body)
    end


    private

    # @return [HTTP::Client]
    # @raise [Flinks::Error]
    def request(method, path, params: {}, body: {})
      headers = {
        'Content-Type' => "application/json",
        'Accept'       => "application/json",
        'User-Agent'   => user_agent
      }

      # Build URL
      url = URI.parse(api_endpoint).merge(path)

      # Build payload
      payload = body.transform_keys { |k| k.to_s.camelize }

      # Perform request
      response = Http.headers(headers).send(method, url, params: params, json: payload)

      if debug
        p response
      end

      # Pass on errors when HTTP status included in 400 to 599
      if (400..599).include?(response.code)
        raise Error.from_response(response)

        on_error.call(response.code, response.reason, body)
      end

      # Return parsed json body
      response.parse
    end
  end
end
