# frozen_string_literal: true

module Flinks
  module API
    module Card

      # https://sandbox-api.flinks.io/Readme/#delete-card-information
      # @param [String] login_id
      # @return [Hash]
      def delete_card(login_id:)
        delete("#{customer_id}/BankingServices/DeleteCard/#{login_id}").tap do |response|
          raise Flinks::NotFound, "Invalid LoginId" if response.match(/Invalid LoginId/)
        end
      end
    end
  end
end
