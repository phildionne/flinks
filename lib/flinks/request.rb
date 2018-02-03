require 'http'

require 'flinks/error'

module Flinks
  module Request

    # Performs a HTTP Get request
    #
    # @param path [String]
    # @param params [Hash]
    def get(path, params: {})
      request(:get, URI.parse(api_endpoint).merge(path), params: params)
    end

    # Performs a HTTP Post request
    #
    # @param path [String]
    # @param params [Hash]
    # @param body [Hash]
    def post(path, params: {}, body: {})
      request(:post, URI.parse(api_endpoint).merge(path), params: params, body: body)
    end

    # Performs a HTTP Patch request
    #
    # @param path [String]
    # @param params [Hash]
    # @param body [Hash]
    def patch(path, params: {}, body: {})
      request(:patch, URI.parse(api_endpoint).merge(path), params: params, body: body)
    end


    private

    # @return [HTTP::Client]
    # @raise [ArgumentError]
    def request(method, path, params: {}, body: {})
      raise ArgumentError, ("Please configure Flinks.customer_id first") if customer_id.nil? || customer_id.empty?

      headers = {
        'Accept'     => "application/json",
        'User-Agent' => user_agent
      }

      response = Http.headers(headers).send(method, path, params: params, json: body.transform_keys(&:camelize))

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
