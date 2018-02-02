module Flinks
  module API
    module Refresh

      # @see https://sandbox-api.flinks.io/Readme/#scheduling-background-refresh
      # @param login_id [String]
      # @return [Hash]
      def activate_scheduled_refresh(login_id:)
        patch("#{customer_id}/BankingServices/ActivateScheduledRefresh", params: { login_id: login_id })
      end

      # @see https://sandbox-api.flinks.io/Readme/#scheduling-background-refresh
      # @param login_id [String]
      # @return [Hash]
      def deactivate_scheduled_refresh(login_id:)
        patch("#{customer_id}/BankingServices/DeactivateScheduledRefresh", params: { login_id: login_id })
      end

      # @see https://sandbox-api.flinks.io/Readme/#scheduling-background-refresh
      # @param login_id [String]
      # @return [Hash]
      def set_scheduled_refresh(login_id:)
        patch("#{customer_id}/BankingServices/SetScheduledRefresh", params: { login_id: login_id })
      end
    end
  end
end
