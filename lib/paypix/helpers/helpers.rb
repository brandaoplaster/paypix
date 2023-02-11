# frozen_string_literal: true

module Helpers
  def self.get_key_in_hash(attributes, key)
    if attributes.has_key?(key)
      attributes[key]
    else
      nil
    end
  end
end
