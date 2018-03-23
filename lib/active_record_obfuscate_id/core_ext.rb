# frozen_string_literal: true

Numeric.include(ActiveRecordObfuscateId::ObfuscateId)
String.include(ActiveRecordObfuscateId::ObfuscateId)

class NilClass
  def to_obfuscated_id; end

  def to_deobfuscate_id; end
end

class Array
  def to_obfuscated_id
    map(&:to_obfuscated_id)
  end

  def to_deobfuscate_id
    map(&:to_deobfuscate_id)
  end
end
