# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'http'

require 'flinks/error'

module Flinks
  module Request

    # Performs a HTTP Get request
    #
    # @param [String] path
    # @param [Hash] params
    def get(path, params: {})
      request(:get, path, params: params)
    end

    # Performs a HTTP Post request
    #
    # @param [String] path
    # @param [Hash] params
    # @param [Hash] body
    def post(path, params: {}, body: {})
      request(:post, path, params: params, body: body)
    end

    # Performs a HTTP Patch request
    #
    # @param [String] path
    # @param [Hash] params
    # @param [Hash] body
    def patch(path, params: {}, body: {})
      request(:patch, path, params: params, body: body)
    end

    # Performs a HTTP Delete request
    #
    # @param [String] path
    # @param [Hash] params
    # @param [Hash] body
    def delete(path, params: {}, body: {})
      request(:delete, path, params: params, body: body)
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
      response = HTTP.headers(headers).send(method, url, params: params, json: payload)

      if debug
        p "Method: #{method}"
        p "Url: #{url}"
        p "Headers: #{headers}"
        p "Payload: #{payload}"
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
      if !raw && raw.is_a?(Hash)
        data.deep_transform_keys { |k| k.underscore }.with_indifferent_access
      else
        data
      end
    end
  end
end
