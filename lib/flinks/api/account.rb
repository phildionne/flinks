module Flinks
  module API
    module Account
      AccountSummaryRequestSchema = Dry::Validation.Schema do
        required(:request_id).filled(:str?)
        optional(:direct_refresh).maybe(:bool?)
        optional(:with_balance).maybe(:bool?)
        optional(:with_transactions).maybe(:bool?)
        optional(:with_account_identity).maybe(:bool?)
        optional(:most_recent).maybe(:bool?)
        optional(:most_recent_cached).maybe(:bool?)
      end

      AccountDetailRequestSchema = Dry::Validation.Schema do
        required(:request_id).filled(:str?)
        optional(:with_account_identity).maybe(:bool?)
        optional(:with_kyc).maybe(:bool?)
        optional(:with_transactions).maybe(:bool?)
        optional(:with_balance).maybe(:bool?)
        optional(:get_mfa_questions_answers).maybe(:bool?)
        optional(:date_from).maybe(:date?)
        optional(:date_to) { date? | date_time? }
        optional(:accounts_filter).each(:str?)

        optional(:refresh_delta).schema do
          each do
            required(:account_id).filled(:str?)
            required(:transaction_id).filled(:str?)
          end
        end

        optional(:days_of_transactions).included_in?(['Days90', 'Days360'])
        optional(:most_recent).maybe(:bool?)
        optional(:most_recent_cached).maybe(:bool?)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-summary
      # @param request_id [String]
      # @param options [Hash]
      # @return [Hash]
      def accounts_summary(request_id:, options: {})
        payload = AccountSummaryRequestSchema.call(options.merge(request_id: request_id))
        raise ArgumentError, payload.messages.first unless payload.success?

        post("#{customer_id}/BankingServices/GetAccountsSummary", body: payload.to_h)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-detail
      # @param request_id [String]
      # @param options [Hash]
      # @return [Hash]
      def accounts_detail(request_id:, options: {})
        payload = AccountDetailRequestSchema.call(options.merge(request_id: request_id))
        raise ArgumentError, payload.messages.first unless payload.success?

        post("#{customer_id}/BankingServices/GetAccountsDetail", body: payload.to_h)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-summary
      # @param request_id [String]
      # @return [Hash]
      def accounts_summary_async(request_id:)
        get("#{customer_id}/BankingServices/GetAccountsSummaryAsync/#{request_id}")
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-detail
      # @param request_id [String]
      # @return [Hash]
      def accounts_detail_async(request_id:)
        get("#{customer_id}/BankingServices/GetAccountsDetailAsync/#{request_id}")
      end
    end
  end
end
