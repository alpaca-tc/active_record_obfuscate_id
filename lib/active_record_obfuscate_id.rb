# frozen_string_literal: true

require 'active_record'

module ActiveRecordObfuscateId
  require 'active_record_obfuscate_id/version'
  require 'active_record_obfuscate_id/obfuscate_id'
  require 'active_record_obfuscate_id/aggregations'
  require 'active_record_obfuscate_id/coder'

  def self.coder
    @coder ||= Coder.new(
      prime: 1_580_030_173,
      inverse: 59_260_789,
      random: 1_163_945_558,
      maximum: 2_147_483_647
    )
  end

  def self.coder=(value)
    @coder = value
  end
end
