# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object'
require 'dry-initializer'

require 'flinks/request'
require 'flinks/api/account'
require 'flinks/api/authorize'
require 'flinks/api/card'
require 'flinks/api/refresh'
require 'flinks/api/statement'

module Flinks
  class Client
    extend Dry::Initializer

    include Flinks::Request
    include Flinks::API::Account
    include Flinks::API::Authorize
    include Flinks::API::Card
    include Flinks::API::Refresh
    include Flinks::API::Statement

    option :customer_id
    option :api_endpoint, default: proc { "https://sandbox.flinks.io/v3/" }
    option :user_agent,   default: proc { "Flinks Ruby Gem" }
    option :on_error,     default: proc { proc {} }
    option :debug,        default: proc { false }


    private

    # Builds an error message from a validation object
    #
    # @param validation [Dry::Validation::Result]
    # @return [String]
    def error_message(validation)
      validation.messages(full: true).values.flatten.to_sentence
    end

    # Validates a request payload against a schema object
    #
    # @param schema [Class]
    # @param options [Hash]
    # @raise [ArgumentError]
    def validate_request!(schema, options)
      payload = schema.call(options)
      raise ArgumentError, error_message(payload) unless payload.success?
    end
  end
end
