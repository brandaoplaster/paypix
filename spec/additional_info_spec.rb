require "spec_helper"
require "paypix/additional_info"

RSpec.describe AdditionalInfo do
  context "Creating an additional info" do
    it "when the parameter is not null then it returns additional info" do
      additional_info = AdditionalInfo.new({ name: "Mike", age: 33 })
      expect(additional_info.name).to eq("Mike")
      expect(additional_info.age).to eq(33)
    end

    context "Instantiating additional info without parameters" do
      let(:additional_info) { AdditionalInfo.new }
      it "when accessing attribute returns error NoMethodError" do
        expect { additional_info.last_name }.to raise_error(NoMethodError)
      end
    end
  end
end
