# frozen_string_literal: true

module ActiveRecordObfuscateId
  module Aggregations
    class ObfuscateId
      def self.from_obfuscated_id(value)
        new ::ActiveRecordObfuscateId.coder.decode(value)
      end

      delegate(:inspect, :to_s, :==, :===, to: :to_obfuscated_id)
      delegate_missing_to(:to_obfuscated_id)

      attr_reader :raw_value, :integer_value, :obfuscated_id

      def initialize(raw_value)
        @raw_value = raw_value
        @integer_value = ActiveRecord::Type.lookup(:integer).cast(raw_value)
        @obfuscated_id = ::ActiveRecordObfuscateId.coder.encode(integer_value)
      end

      def to_obfuscated_id
        obfuscated_id
      end
    end

    def compose_of_obfuscated(column_name: primary_key)
      composed_of(
        :"obfuscated_#{column_name}",
        class_name: 'ActiveRecordObfuscateId::Aggregations::ObfuscateId',
        mapping: [%W[#{column_name} raw_value]],
        converter: ->(value) {
          ActiveRecordObfuscateId::Aggregations::ObfuscateId.from_obfuscated_id(value)
        }
      )
    end
  end
end
