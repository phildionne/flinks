require 'dry-validation'

require 'flinks/request'
require 'flinks/api/account'
require 'flinks/api/card'
require 'flinks/api/refresh'
module Flinks
  class Client
    include Flinks::Request
    include Flinks::API::Account
    include Flinks::API::Card
    include Flinks::API::Refresh

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # @param options [Hash]
    def initialize(options = {})
      options = Flinks.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
