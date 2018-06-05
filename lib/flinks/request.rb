# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'http'

require 'flinks/error'

module Flinks
  module Request

    # Performs a HTTP Get request
    #
    # @param path [String]
    # @param params [Hash]
    def get(path, params: {}, async: false)
      request(:get, path, params: params, async: async)
    end

    # Performs a HTTP Delete request
    #
    # @param path [String]
    # @param params [Hash]
    def delete(path, params: {}, async: false)
      request(:delete, path, params: params, async: async)
    end

    # Performs a HTTP Post request
    #
    # @param path [String]
    # @param params [Hash]
    # @param body [Hash]
    def post(path, params: {}, body: {}, async: false)
      request(:post, path, params: params, body: body, async: async)
    end

    # Performs a HTTP Patch request
    #
    # @param path [String]
    # @param params [Hash]
    # @param body [Hash]
    def patch(path, params: {}, body: {}, async: false)
      request(:patch, path, params: params, body: body, async: async)
    end

    private

    # @return [HTTP::Client]
    # @raise [Flinks::Error]
    def request(method, path, params: {}, body: {}, async: false)
      headers = {
        'Content-Type' => "application/json",
        'Accept'       => "application/json",
        'User-Agent'   => user_agent
      }

      # Build URL
      url = URI.parse(api_endpoint).merge(path)

      # Build payload
      payload = body.transform_keys { |k| k.to_s.camelize }

      if debug
        p "Method: #{method}"
        p "Url: #{url}"
        p "Headers: #{headers}"
        p "Payload: #{payload}"
        p "Response: loading..."
      end

      # Perform request
      if async
        response = Http.headers(headers).send(method, url)
      else
        response = Http.headers(headers).send(method, url, params: params, json: payload)
      end

      if debug
        p "Response: #{response}"
      end

      # Pass on errors when HTTP status included in 400 to 599
      if (400..599).include?(response.code)
        raise Error.from_response(response)

        on_error.call(response.code, response.reason, body)
      end

      # Parse body
      data = response.parse

      # Transform data
      data.deep_transform_keys { |k| k.underscore }.with_indifferent_access

    rescue JSON::ParserError
      response
    end
  end
end
