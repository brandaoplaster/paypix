require "spec_helper"
require "paypix/helpers/helpers"

RSpec.describe Helpers do
  context "recovering values with key exists" do
    let(:data) {
      {
        :payer => {
          :document_number => "111.222.333-04",
          :name => "Mike",
        },
        :charge => {
          :amount => 10.50,
          :pix_account_id => 90,
          :expire_at => "2023-12-02 10:03:56",
          :message => "Hello word",
        },
      }
    }

    it "when the hash has the key then it returns value" do
      expect(Helpers.get_key_in_hash(data, :charge)).to be(data[:charge])
    end

    it "when the hash does not have the key then it returns nil" do
      expect(Helpers.get_key_in_hash(data, :additional_info)).to be_nil
    end
  end
end
