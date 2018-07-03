# frozen_string_literal: true

module Flinks
  module API
    module Card

      # https://sandbox-api.flinks.io/Readme/#delete-card-information
      # @param [String] login_id
      # @return [Hash]
      def delete_card(login_id:)
        delete("#{customer_id}/BankingServices/DeleteCard/#{login_id}")
      end
    end
  end
end
