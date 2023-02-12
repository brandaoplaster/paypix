require "spec_helper"
require "paypix/payer"

RSpec.describe Payer do
  context "Creating a Payer" do
    it "when parameters are valid" do
      payer = Payer.new({ name: "Mike", document_number: "1223344" })
      expect(payer.name).to eq("Mike")
      expect(payer.document_number).to eq("1223344")
    end

    it "when you only send the name parameter" do
      expect { Payer.new({ name: "Mike" }) }.to raise_error(ArgumentError)
    end

    it "when you only send the document_number parameter" do
      expect { Payer.new({ document_number: "1223344" }) }.to raise_error(ArgumentError)
    end

    it "when parameters are nil" do
      expect { Payer.new(nil) }.to raise_error(NoMethodError)
    end
  end
end
