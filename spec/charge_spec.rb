require "spec_helper"
require "paypix/charge"
require "paypix/payer"
require "paypix/additional_info"

RSpec.describe Charge do
  context "creating a charge" do
    context "valid parameters" do
      let(:charge) {
        {
          :amount => 10.50,
          :pix_account_id => 90,
          :expire_at => "2023-12-02 10:03:56",
          :message => "Hello word",
        }
      }

      it "when charge is created correctly" do
        payer = Payer.new({ name: "Mike", document_number: "111.222.333-04" })
        additional_info = AdditionalInfo.new({ last_name: "Vik" })
        object = Charge.new(charge, payer, additional_info)

        expect(object).to be_an_instance_of(Charge)
        expect(object.amount).to eq(10.50)
      end
    end

    context "invalid parameters" do
      it "when amount parameter is not sent" do
        charge = {
          :pix_account_id => 90,
          :expire_at => "2023-12-02 10:03:56",
          :message => "Hello word",
        }
        expect { Charge.new(charge, nil, nil) }.to raise_error(ArgumentError, "amount is required")
      end

      it "when expire_at parameter is not sent" do
        charge = {
          :amount => 10.50,
          :pix_account_id => 90,
          :message => "Hello word",
        }
        expect { Charge.new(charge, nil, nil) }.to raise_error(ArgumentError, "expire_at is required")
      end

      it "when pix_account_id parameter is not sent" do
        charge = {
          :amount => 10.50,
          :expire_at => "2023-12-02 10:03:56",
          :message => "Hello word",
        }
        expect { Charge.new(charge, nil, nil) }.to raise_error(ArgumentError, "pix_account_id is required")
      end
    end
  end
end
