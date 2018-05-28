require 'spec_helper'

describe Flinks::API::Refresh do
  let(:api_endpoint) { Flinks::Client.dry_initializer.definitions[:api_endpoint].default.call }
  let(:client) { Flinks.new(customer_id: 'customer_id') }
  let(:login_id) { 'login_id' }

  describe '#set_scheduled_refresh' do
    before do
      stub_request(:patch, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.set_scheduled_refresh(true, login_id: login_id)).to be_a(Hash)
    end
  end
end
