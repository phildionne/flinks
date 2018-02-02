module Flinks
  module API
    module Statement
      StatementRequestSchema = Dry::Validation.Schema do
        optional(:accounts_filter).each(:str?)
        optional(:number_of_statements).included_in?(['MostRecent', 'Months3', 'Months12'])
        optional(:most_recent).maybe(:bool?)
        optional(:most_recent_cached).maybe(:bool?)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-pdf-statements
      # @param request_id [String]
      # @param options [Hash]
      # @return [Hash]
      def statements(request_id:, options: {})
        payload = StatementRequestSchema.call(options)
        raise Error, payload.messages.first unless payload.success?

        post("#{customer_id}/BankingServices/GetStatements", body: payload.to_h)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-pdf-statements
      # @param request_id [String]
      # @return [Hash]
      def statements_async(request_id:)
        get("#{customer_id}/BankingServices/GetStatementsAsync/#{request_id}")
      end
    end
  end
end
