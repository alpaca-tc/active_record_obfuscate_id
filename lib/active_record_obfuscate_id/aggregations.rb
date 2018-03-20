# frozen_string_literal: true

module ActiveRecordObfuscateId
  module Aggregations
    class ObfuscateId
      def self.from_obfuscated_id(value)
        new(value)
      end

      delegate_missing_to(:to_obfuscated_id)
      delegate(:inspect, :to_s, :==, :===, to: :to_obfuscated_id)

      def initialize(raw_value)
        @raw_value = raw_value
      end

      def to_obfuscated_id
        ::ActiveRecordObfuscateId::Code.encode(@raw_value)
      end
    end

    def compose_of_obfuscated(column_name: primary_key)
      composed_of(
        :"obfuscated_#{column_name}",
        class_name: 'ActiveRecordObfuscateId::Aggregations::ObfuscateId',
        mapping: [%W[#{column_name} to_obfuscated_id]],
        converter: ->(value) { ActiveRecordObfuscateId::Aggregations::ObfuscateId.from_obfuscated_id(value) }
      )
    end
  end
end
