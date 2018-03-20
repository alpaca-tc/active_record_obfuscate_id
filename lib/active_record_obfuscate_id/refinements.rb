# frozen_string_literal: true

module ActiveRecordObfuscateId
  module Refinements
    refine Integer do
      def to_obfuscated_id
        ActiveRecordObfuscateId::Id.new(self).to_obfuscated_id
      end
    end

    refine String do
      def to_obfuscated_id
        integer = ActiveRecord::Type.lookup(:integer).cast(self)
        integer&.to_obfuscated_id
      end
    end
  end
end
