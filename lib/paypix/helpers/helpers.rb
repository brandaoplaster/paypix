# frozen_string_literal: true

module Helpers
  def self.valid_hash?(hash)
    required_keys = [:amount, :pix_account_id, :expire_at]
    expected_types = { amount: Float, payer: Hash, pix_account_id: Integer, txid: String }

    required_keys.each do |key|
      raise ArgumentError, "Key #{key} is required and not found in the hash" unless hash.key?(key)
    end

    true
  rescue ArgumentError => e
    puts e.message
    false
  end
end
