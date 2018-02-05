require 'spec_helper'

describe Flinks::API::Statement do
  let(:api_endpoint) { Flinks::Client.dry_initializer.definitions[:api_endpoint].default.call }
  let(:client) { Flinks.new(customer_id: 'customer_id') }
  let(:request_id) { 'request_id' }

  describe '#statements' do
    before do
      stub_request(:post, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.statements).to be_a(Hash)
    end

    context "with valid options" do
      let(:options) do
        {
          accounts_filter: ['string'],
          number_of_statements: 'MostRecent',
          most_recent: true,
          most_recent_cached: true
        }
      end

      it "returns an object" do
        expect(client.statements(options: options)).to be_a(Hash)
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          accounts_filter: 'invalid',
          number_of_statements: 'invalid',
          most_recent: 'invalid',
          most_recent_cached: 'invalid'
        }
      end

      it "raises an error" do
        expect {
          client.statements(options: options)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#statements_async' do
    before do
      stub_request(:get, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.statements_async(request_id: request_id)).to be_a(Hash)
    end
  end
end
