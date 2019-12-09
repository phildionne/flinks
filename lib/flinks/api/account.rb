# frozen_string_literal: true

require 'dry-schema'

module Flinks
  module API
    module Account
      AccountSummaryRequestSchema = Dry::Schema.Params do
        required(:request_id).filled(:string)
        optional(:direct_refresh).filled(:bool)
        optional(:with_balance).filled(:bool)
        optional(:with_transactions).filled(:bool)
        optional(:with_account_identity).filled(:bool)
        optional(:most_recent).filled(:bool)
        optional(:most_recent_cached).filled(:bool)
      end

      AccountDetailRequestSchema = Dry::Schema.Params do
        required(:request_id).filled(:string)
        optional(:with_account_identity).filled(:bool)
        optional(:with_kyc).filled(:bool)
        optional(:with_transactions).filled(:bool)
        optional(:with_balance).filled(:bool)
        optional(:get_mfa_questions_answers).filled(:bool)
        optional(:date_from).filled(:date?)
        optional(:date_to) { date? | date_time? }
        optional(:accounts_filter).array(:string)

        optional(:refresh_delta).array(:hash) do
          required(:account_id).filled(:string)
          required(:transaction_id).filled(:string)
        end

        optional(:days_of_transactions).value(included_in?: ['Days90', 'Days360'])
        optional(:most_recent).filled(:bool)
        optional(:most_recent_cached).filled(:bool)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-summary
      # @param [String] request_id
      # @param [Hash] options
      # @return [Hash]
      def accounts_summary(request_id:, options: {})
        payload = options.merge(request_id: request_id)
        validate_request!(AccountSummaryRequestSchema, payload)

        post("#{customer_id}/BankingServices/GetAccountsSummary", body: payload)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-detail
      # @param [String] request_id
      # @param [Hash] options
      # @return [Hash]
      def accounts_detail(request_id:, options: {})
        payload = options.merge(request_id: request_id)
        validate_request!(AccountDetailRequestSchema, payload)

        post("#{customer_id}/BankingServices/GetAccountsDetail", body: payload)
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-summary
      # @param [String] request_id
      # @return [Hash]
      def accounts_summary_async(request_id:)
        get("#{customer_id}/BankingServices/GetAccountsSummaryAsync/#{request_id}")
      end

      # @see https://sandbox-api.flinks.io/Readme/#get-accounts-detail
      # @param [String] request_id
      # @return [Hash]
      def accounts_detail_async(request_id:)
        get("#{customer_id}/BankingServices/GetAccountsDetailAsync/#{request_id}")
      end
    end
  end
end
