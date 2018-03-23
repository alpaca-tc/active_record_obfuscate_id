# frozen_string_literal: true

module ActiveRecordObfuscateId
  module Aggregations
    class ObfuscateId < BasicObject
      def self.from_obfuscated_id(value)
        new(value)
      end

      delegate(:==, :===, to: :to_obfuscated_id)
      delegate_missing_to(:to_obfuscated_id)

      def initialize(raw_value)
        @raw_value = raw_value
      end

      def to_obfuscated_id
        @raw_value.to_obfuscated_id
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
