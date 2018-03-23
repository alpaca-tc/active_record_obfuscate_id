# frozen_string_literal: true

RSpec.describe ActiveRecordObfuscateId::Coder do
  let(:instance) do
    described_class.new(
      prime: 1_580_030_173,
      inverse: 59_260_789,
      random: 1_163_945_558,
      maximum: 2_147_483_647
    )
  end

  describe '#encode' do
    let(:value) { 1 }

    it do
      result = instance.encode(value)
      expect(result).to_not eq(value)
      expect(instance.decode(result)).to eq(value)
    end
  end
end
