require "net/http"
require "json"
require "dotenv/load"

class ApiClient
  BASE_URL = "https://api-sandbox.kobana.com.br/v2/"

  attr_reader :bearer_token

  def initialize
    @bearer_token = ENV["API_KEY"]
    validate_api_key
    @http_client = http_client()
  end

  def post(path, data)
    url = URI("#{BASE_URL}#{path}")

    request = Net::HTTP::Post.new(url)
    add_bearer_token_in_request(request)

    request.body = data.to_json
    response = @http_client.request(request)

    JSON.parse(response.body)
  end

  private

  def validate_api_key
    raise "Your API_KEY cannot be nil!" if @bearer_token.nil?
  end

  def http_client
    url = URI(BASE_URL.to_s)
    http_client = Net::HTTP.new(url.host, url.port)
    http_client.use_ssl = true
    http_client
  end

  def add_bearer_token_in_request(request)
    request["authorization"] = "Bearer #{@bearer_token}"
    request["content-type"] = "application/json"
  end
end
