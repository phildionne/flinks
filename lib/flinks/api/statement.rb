# frozen_string_literal: true

require 'dry-schema'

module Flinks
  module API
    module Statement
      StatementRequestSchema = Dry::Schema.Params do
        optional(:accounts_filter).array(:string)
        optional(:number_of_statements).value(included_in?: ['MostRecent', 'Months3', 'Months12'])
        optional(:most_recent).maybe(:bool)
        optional(:most_recent_cached).maybe(:bool)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-pdf-statements
      # @param [Hash] options
      # @return [Hash]
      def statements(options: {})
        validate_request!(StatementRequestSchema, options)
        post("#{customer_id}/BankingServices/GetStatements", body: options)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-pdf-statements
      # @param [String] request_id
      # @return [Hash]
      def statements_async(request_id:)
        get("#{customer_id}/BankingServices/GetStatementsAsync/#{request_id}")
      end
    end
  end
end
