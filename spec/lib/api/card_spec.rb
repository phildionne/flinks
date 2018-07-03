require 'spec_helper'

describe Flinks::API::Card do
  let(:api_endpoint) { Flinks::Client.dry_initializer.definitions[:api_endpoint].default.call }
  let(:client) { Flinks.new(customer_id: 'customer_id') }
  let(:login_id) { 'login_id' }

  describe '#delete_card' do
    before do
      stub_request(:get, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.delete_card(login_id: login_id)).to be_a(Hash)
    end
  end
end
