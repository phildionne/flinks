require 'spec_helper'

describe Flinks::Client do

  describe "#initialize" do
    it "without required arguments" do
      expect { Flinks::Client.new }.to raise_error KeyError
    end

    it "with required arguments" do
      client = Flinks::Client.new(customer_id: 'token')
      expect(client.customer_id).to eq('token')
    end

    it "sets defaults" do
      client = Flinks::Client.new(customer_id: 'token')
      expect(client.api_endpoint).not_to be_nil
      expect(client.user_agent).not_to be_nil
      expect(client.on_error).not_to be_nil
      expect(client.debug).not_to be_nil
    end
  end
end
