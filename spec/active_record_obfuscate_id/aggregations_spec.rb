# frozen_string_literal: true

RSpec.describe ActiveRecordObfuscateId::Aggregations do
  User.extend(ActiveRecordObfuscateId::Aggregations)
  User.compose_of_obfuscated

  describe '.compose_of_obfuscated_id' do
    before do
      allow(ActiveRecordObfuscateId::Code).to receive(:encode).and_return(100)
    end

    it 'assign value from aggregation' do
      expect(User.new(id: 1).id).to eq(1)
      expect(User.new(obfuscated_id: 1).id).to eq(100)
    end

    it 'calculates value with aggregation' do
      expect(User.new(id: 1).obfuscated_id).to eq(100)
      expect(User.new(obfuscated_id: 1).id).to eq(100)
    end

    it 'converts value from "1".to_obfuscated_id' do
      expect(User.where(id: 1).to_sql).to match(/"id" = 1/)
      expect(User.where(obfuscated_id: 1).to_sql).to match(/"id" = 100/)
    end
  end
end
