require 'flinks/configuration'
require 'flinks/client'

module Flinks
  extend Configuration

  # Alias for Flinks::Client.new
  #
  # @return [Flinks::Client]
  def new(options = {})
    Flinks::Client.new(options)
  end
  module_function :new
end
