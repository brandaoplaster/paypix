# frozen_string_literal: true

RSpec.describe Paypix do
  context "Creating Pix" do
    let(:path) { "charge/pix" }
    let(:url) { "#{ApiClient::BASE_URL}#{path}" }
    let(:request_headers) do
      {
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Content-Type" => "application/json",
        "Host" => "api-sandbox.kobana.com.br",
        "User-Agent" => "Ruby",
      }
    end

    context "successful creation" do
      let(:response_body) {
        {
          :status => 201,
          :data => {
            :id => 42,
            :status => "opened",
            :pix_account_id => 42,
            :created_at => "2023-02-09T08:16:18+12:00",
            :expire_at => "2023-02-19T08:16:18+12:00",
            :amount => 100.5,
            :payer => {
              :document_number => "652.388.162-86",
              :name => "John Doe",
            },
          },
        }.to_json
      }
      let(:response) { double("response", body: response_body) }
      let(:data) {
        {
          "payer": {
            "document_number": "652.388.162-86",
            "name": "John Doe",
          },
          "amount": 100.5,
          "pix_account_id": 1,
          "expire_at": "2023-02-19T08:16:18+12:00",
          "message": "Hello word",
        }
      }
      before do
        stub_request(:post, url)
          .with(body: data.to_json, headers: request_headers)
          .to_return(status: 201, body: response_body)
      end

      it "when parameters are valid" do
        pix = Paypix::Pix.new

        respone = pix.create(data)

        expect(respone).to include("status" => 201)
        expect(WebMock).to have_requested(:post, url).with(body: data.to_json, headers: request_headers)
      end
    end
  end

  it "has a version number" do
    expect(Paypix::VERSION).not_to be nil
  end
end
