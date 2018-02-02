require 'spec_helper'

describe Flinks::Client do
  after do
    Flinks.reset!
  end

  context "with module configuration" do
    before do
      Flinks.configure do |config|
        config.customer_id = 'token'
      end
    end

    it "inherits the module configuration" do
      expect(Flinks.send(:customer_id)).to eq('token')
    end
  end

  context "with class configuration" do
    before do
      Flinks.configure do |config|
        config.customer_id = 'token'
      end
    end

    let(:client) { Flinks.new(customer_id: 'another') }

    it "overrides the module configuration after initialization" do
      expect(client.customer_id).to eq('another')
    end
  end

  describe "#request" do
    let(:client) { Flinks.new(customer_id: 'token') }

    it "raises on absent customer_id" do
      client.customer_id = nil
      expect { client.get("whatever") }.to raise_error(ArgumentError)
    end
  end
end
