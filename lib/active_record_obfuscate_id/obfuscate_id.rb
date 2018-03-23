# frozen_string_literal: true

module ActiveRecordObfuscateId
  module ObfuscateId
    def to_obfuscated_id
      ActiveRecordObfuscateId.coder.encode(self)
    end

    def to_deobfuscate_id
      ActiveRecordObfuscateId.coder.decode(self)
    end
  end
end
