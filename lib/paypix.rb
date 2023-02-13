# frozen_string_literal: true

require_relative "paypix/version"
require_relative "paypix/client/api_client"
require_relative "paypix/helpers/helpers"

module Paypix
  class Pix
    def initialize
      @api_client = ApiClient.new
    end

    def create(attributes)
      if Helpers.valid_hash?(attributes)
        @api_client.post("charge/pix", attributes)
      end
    end
  end
end
