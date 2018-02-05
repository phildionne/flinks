require 'spec_helper'

describe Flinks::API::Account do
  let(:api_endpoint) { Flinks::Client.dry_initializer.definitions[:api_endpoint].default.call }
  let(:client) { Flinks.new(customer_id: 'customer_id') }
  let(:request_id) { 'request_id' }

  describe '#accounts_summary' do
    before do
      stub_request(:post, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.accounts_summary(request_id: request_id)).to be_a(Hash)
    end

    context "with valid options" do
      let(:options) do
        {
          direct_refresh: true,
          with_balance: true,
          with_transactions: true,
          with_account_identity: true,
          most_recent: true,
          most_recent_cached: true
        }
      end

      it "returns an object" do
        expect(client.accounts_summary(request_id: request_id, options: options)).to be_a(Hash)
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          direct_refresh: 'invalid',
          with_balance: 'invalid',
          with_transactions: 'invalid',
          with_account_identity: 'invalid',
          most_recent: 'invalid',
          most_recent_cached: 'invalid'
        }
      end

      it "raises an error" do
        expect {
          client.accounts_summary(request_id: request_id, options: options)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#accounts_detail' do
    before do
      stub_request(:post, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    context "with valid options" do
      let(:options) do
        {
          with_account_identity: true,
          with_kyc: true,
          with_transactions: true,
          with_balance: true,
          get_mfa_questions_answers: true,
          date_from: Date.today,
          date_to: Date.today,
          accounts_filter: ['string'],
          refresh_delta: [{ account_id: 'id', transaction_id: 'id' }],
          days_of_transactions: 'Days90',
          most_recent: true,
          most_recent_cached: true
        }
      end

      it "returns an object" do
        expect(client.accounts_detail(request_id: request_id, options: options)).to be_a(Hash)
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          with_account_identity: 'invalid',
          with_kyc: 'invalid',
          with_transactions: 'invalid',
          with_balance: 'invalid',
          get_mfa_questions_answers: 'invalid',
          date_from: 'invalid',
          date_to: 'invalid',
          accounts_filter: 'invalid',
          refresh_delta: 'invalid',
          days_of_transactions: 'invalid',
          most_recent: 'invalid',
          most_recent_cached: 'invalid'
        }
      end

      it "raises an error" do
        expect {
          client.accounts_detail(request_id: request_id, options: options)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#accounts_summary_async' do
    before do
      stub_request(:get, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.accounts_summary_async(request_id: request_id)).to be_a(Hash)
    end
  end

  describe '#accounts_detail_async' do
    before do
      stub_request(:get, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.accounts_detail_async(request_id: request_id)).to be_a(Hash)
    end
  end
end
