require "spec_helper"
require "paypix/helpers/helpers"

RSpec.describe Helpers do
  context "validating the input hash" do
    context "valid hash" do
      let(:data) {
        {
          :payer => {
            :document_number => "111.222.333-04",
            :name => "Mike",
          },
          :amount => 10.50,
          :pix_account_id => 90,
          :expire_at => "2023-12-02 10:03:56",
          :message => "Hello word",
        }
      }

      it "when the hash is valid it returns true" do
        expect(Helpers.valid_hash?(data)).to be(true)
      end
    end

    context "invalid hash" do
      let(:data) {
        {
          :payer => {
            :document_number => "111.222.333-04",
            :name => "Mike",
          },
          :amount => 10.50,
          :pix_account_id => 90,
          :message => "Hello word",
        }
      }
      it "when the hash is not valid it returns false" do
        expect(Helpers.valid_hash?(data)).to be(false)
      end
    end
  end
end
