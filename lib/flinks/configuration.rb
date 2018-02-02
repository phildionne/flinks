require 'active_support/core_ext/hash/indifferent_access'
require 'flinks/version'

module Flinks
  module Configuration
    VALID_OPTIONS_KEYS = %w(api_endpoint customer_id user_agent on_error debug).freeze

    DEFAULT_API_ENDPOINT = "https://sandbox.flinks.io/v3/"
    DEFAULT_USER_AGENT   = "Flinks Ruby Gem #{Flinks::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset!
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      ActiveSupport::HashWithIndifferentAccess[ * VALID_OPTIONS_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def reset!
      self.api_endpoint = DEFAULT_API_ENDPOINT
      self.user_agent   = DEFAULT_USER_AGENT
      self.on_error     = Proc.new {}
      self.debug        = false
      self.customer_id  = nil

      return true
    end
  end
end
