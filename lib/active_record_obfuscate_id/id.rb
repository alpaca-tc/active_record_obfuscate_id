# frozen_string_literal: true

module ActiveRecordObfuscateId
  module Id
    def to_obfuscated_id
      ActiveRecordObfuscateId::Code.encode(self)
    end

    def to_deobfuscate_id
      ActiveRecordObfuscateId::Code.decode(self)
    end
  end
end
