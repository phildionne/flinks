module Flinks
  module API
    module Refresh

      # @see https://sandbox-api.flinks.io/Readme/#scheduling-background-refresh
      # @param activated [Boolean]
      # @param login_id [String]
      # @return [Hash]
      def set_scheduled_refresh(activated, login_id:)
        patch("#{customer_id}/BankingServices/SetScheduledRefresh", params: { login_id: login_id, is_activated: activated })
      end
    end
  end
end
