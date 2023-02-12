require "spec_helper"
require "paypix/client/api_client"

RSpec.describe ApiClient do
  describe "POST create pix" do
    let(:path) { "/charge/pix" }
    let(:url) { "#{ApiClient::BASE_URL}#{path}" }
    let(:request_headers) do
      {
        "content-type" => "application/json",
        "Accept" => "*/*",
        "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Content-Type" => "application/json",
        "Host" => "api-sandbox.kobana.com.br",
        "User-Agent" => "Ruby",
      }
    end

    context "with request success" do
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
            "document_number": "111.321.322-09",
            "name": "Lucas B.",
          },
          "additional_info": {
            "chave": "valor",
          },
          "charge": {
            "amount": 10.50,
            "pix_account_id": 1,
            "expire_at": "2023-12-02T10:03:56-03:00",
            "message": "Hello word",
          },
        }
      }
      before do
        stub_request(:post, url)
          .with(body: data.to_json, headers: request_headers)
          .to_return(status: 201, body: response_body)
      end

      it "pix created with customer data" do
        api_client = ApiClient.new()

        result = api_client.post(path, data)

        expect(result).to include("status" => 201)
        expect(WebMock).to have_requested(:post, url).with(body: data.to_json, headers: request_headers)
      end
    end

    context "with request problem" do
      let(:response_body) {
        {
          :status => 401,
          :errors => [
            {
              :title => "Token de API inválido (Servidor: test)",
              :code => "unauthorized",
              :detail => "O Token de API é diferente para cada Servidor/URL, mais em https://developers.kobana.com.br/reference/token-de-acesso",
            },
          ],
        }.to_json
      }

      let(:data) {
        {
          "payer": {
            "document_number": "111.321.322-09",
            "name": "Lucas B.",
          },
          "additional_info": {
            "chave": "valor",
          },
          "charge": {
            "amount": 10.50,
            "pix_account_id": 1,
            "expire_at": "2023-12-02T10:03:56-03:00",
            "message": "Hello word",
          },
        }
      }

      before do
        stub_request(:post, url)
          .with(body: data.to_json, headers: request_headers)
          .to_return(status: 401, body: response_body)
      end

      it "authentication failure, invalid token" do
        api_client = ApiClient.new()
        response = api_client.post(path, data)

        expect(response["errors"][0]).to include("code" => "unauthorized")
        expect(WebMock).to have_requested(:post, url).with(body: data.to_json, headers: request_headers)
      end

      context "validation error" do
        let(:response_body) {
          {
            :status => 422,
            :errors => [
              {
                :code => "validation_error",
                :param => "amount",
                :detail => "Quantia não pode ficar em branco",
              },
            ],
          }.to_json
        }

        before do
          stub_request(:post, url)
            .with(body: data.to_json, headers: request_headers)
            .to_return(status: 422, body: response_body)
        end

        it "when required field not submitted" do
          api_client = ApiClient.new()
          response = api_client.post(path, data)

          expect(response).to include("status" => 422)
          expect(response["errors"][0]).to include("param" => "amount")
          expect(WebMock).to have_requested(:post, url).with(body: data.to_json, headers: request_headers)
        end
      end
    end
  end
end
