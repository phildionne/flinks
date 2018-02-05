require 'dry-validation'

module Flinks
  module API
    module Authorize
      AuthorizeRequestSchema = Dry::Validation.Schema do
        required(:login_id).filled(:str?)

        optional(:language).filled(:str?)
        optional(:save).filled(:bool?)
        optional(:security_responses).filled(:hash?)
        optional(:schedule_refresh).filled(:bool?)
        optional(:direct_refresh).filled(:bool?)
        optional(:days_of_transactions).included_in?(['Days90', 'Days360'])
        optional(:most_recent_cached).filled(:bool?)
        optional(:with_transactions).filled(:bool?)
        optional(:with_balance).filled(:bool?)
      end

      AuthorizeWithCredentialsRequestSchema = Dry::Validation.Schema do
        required(:username).filled?(:str?)
        required(:password).filled?(:str?)
        required(:institution).filled?(:str?)

        optional(:language).filled(:str?)
        optional(:save).filled(:bool?)
        optional(:security_responses).filled(:hash?)
        optional(:schedule_refresh).filled(:bool?)
        optional(:direct_refresh).filled(:bool?)
        optional(:days_of_transactions).included_in?(['Days90', 'Days360'])
        optional(:most_recent_cached).filled(:bool?)
        optional(:with_transactions).filled(:bool?)
        optional(:with_balance).filled(:bool?)
      end

      AuthorizeMultipleRequestSchema = Dry::Validation.Schema do
        required(:login_ids).each(:str?)
      end

      # @see https://sandbox-api.flinks.io/Readme/#authorize
      # @param login_id [String]
      # @param options [Hash]
      # @return [Hash]
      def authorize(login_id:, options: {})
        payload = AuthorizeRequestSchema.call(options.merge(login_id: login_id))
        raise ArgumentError, error_message(payload) unless payload.success?

        post("#{customer_id}/BankingServices/Authorize", body: payload.to_hash)
      end

      # @see https://sandbox-api.flinks.io/Readme/#authorize
      # @param username [String]
      # @param password [String]
      # @param institution [String]
      # @param options [Hash]
      def authorize_with_credentials(username:, password:, institution:, options: {})
        payload = AuthorizeWithCredentialsRequestSchema.call(options.merge(username: username, password: password, institution: institution))
        raise ArgumentError, error_message(payload) unless payload.success?

        post("#{customer_id}/BankingServices/Authorize", body: payload.to_hash)
      end

      # @see https://sandbox-api.flinks.io/Readme/#authorize-multiple
      # @param login_ids [Array]
      # @return [Hash]
      def authorize_multiple(login_ids:)
        payload = AuthorizeMultipleRequestSchema.call(options.merge(login_ids: login_ids))
        raise ArgumentError, error_message(payload) unless payload.success?

        post("#{customer_id}/BankingServices/AuthorizeMultiple", body: payload.to_hash)
      end
    end
  end
end
