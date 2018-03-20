# frozen_string_literal: true

module ActiveRecordObfuscateId
  class Id
    def initialize(raw_id)
      @raw_id = raw_id
    end

    def to_obfuscated_id
      @raw_id + 100
    end
  end
end
