require 'flinks/request'
module Flinks
  class Client
    include Flinks::Request

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
