# frozen_string_literal: true

require 'flinks/client'

module Flinks

  # Alias for Flinks::Client.new
  #
  # @return [Flinks::Client]
  def new(options = {})
    Flinks::Client.new(options)
  end
  module_function :new
end
