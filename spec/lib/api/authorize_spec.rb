require 'spec_helper'

describe Flinks::API::Authorize do
  let(:api_endpoint) { Flinks::Client.dry_initializer.definitions[:api_endpoint].default.call }
  let(:client) { Flinks.new(customer_id: 'customer_id') }

  describe '#authorize' do
    let(:login_id) { 'login_id' }

    before do
      stub_request(:post, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.authorize(login_id: login_id)).to be_a(Hash)
    end

    context "with valid options" do
      let(:options) do
        {
          language: 'language',
          save: true,
          security_responses: {
            'Question': ['response']
          },
          schedule_refresh: true,
          direct_refresh: true,
          days_of_transactions: 'Days90',
          most_recent_cached: true,
          with_transactions: true,
          with_balance: true
        }
      end

      it "returns an object" do
        expect(client.authorize(login_id: login_id, options: options)).to be_a(Hash)
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          language: 'invalid',
          save: 'invalid',
          security_responses: 'invalid',
          schedule_refresh: 'invalid',
          direct_refresh: 'invalid',
          days_of_transactions: 'invalid',
          most_recent_cached: 'invalid',
          with_transactions: 'invalid',
          with_balance: 'invalid'
        }
      end

      it "raises an error" do
        expect {
          client.accounts_summary(login_id: login_id, options: options)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#authorize_with_credentials' do
    let(:username) { 'username' }
    let(:password) { 'password' }
    let(:institution) { 'institution' }

    before do
      stub_request(:post, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    context "with valid options" do
      let(:options) do
        {
          language: 'language',
          save: true,
          security_responses: {
            'Question': ['response']
          },
          schedule_refresh: true,
          direct_refresh: true,
          days_of_transactions: 'Days90',
          most_recent_cached: true,
          with_transactions: true,
          with_balance: true
        }
      end

      it "returns an object" do
        expect(client.authorize_with_credentials(username: username, password: password, institution: institution, options: options)).to be_a(Hash)
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          language: 'invalid',
          save: 'invalid',
          security_responses: 'invalid',
          schedule_refresh: 'invalid',
          direct_refresh: 'invalid',
          days_of_transactions: 'invalid',
          most_recent_cached: 'invalid',
          with_transactions: 'invalid',
          with_balance: 'invalid'
        }
      end

      it "raises an error" do
        expect {
          client.authorize_with_credentials(username: username, password: password, institution: institution, options: options)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#authorize_multiple' do
    let(:login_ids) { ['login_id_1', 'login_id_2'] }

    before do
      stub_request(:post, /#{api_endpoint}/)
        .to_return(status: 200, body: "{}", headers: { 'Content-Type'=>'application/json' })
    end

    it "returns an object" do
      expect(client.authorize_multiple(login_ids: login_ids)).to be_a(Hash)
    end

    context "with valid options" do
      let(:options) do
        {
          most_recent_cached: true,
        }
      end

      it "returns an object" do
        expect(client.authorize_multiple(login_ids: login_ids, options: options)).to be_a(Hash)
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          most_recent_cached: 'invalid'
        }
      end

      it "raises an error" do
        expect {
          client.authorize_multiple(login_ids: login_ids, options: options)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
