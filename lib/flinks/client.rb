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
    option :raw,          default: proc { false }


    private

    # Builds an error message from a validation object
    #
    # @param [Dry::Schema::Result] validation
    # @return [String]
    def error_message(validation)
      validation.errors(full: true).to_h.values.to_sentence
    end

    # Validates a request payload against a schema object
    #
    # @param [Class] schema
    # @param [Hash] payload
    # @raise [ArgumentError]
    def validate_request!(schema, payload)
      validation = schema.call(payload)
      raise ArgumentError, error_message(validation) unless validation.success?
    end
  end
end
