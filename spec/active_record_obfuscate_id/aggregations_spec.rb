# frozen_string_literal: true

RSpec.describe ActiveRecordObfuscateId::Aggregations do
  User.extend(ActiveRecordObfuscateId::Aggregations)
  User.compose_of_obfuscated

  Cart.extend(ActiveRecordObfuscateId::Aggregations)
  Cart.compose_of_obfuscated(column_name: :user_id)

  describe '.compose_of_obfuscated_id' do
    before do
      allow_any_instance_of(ActiveRecordObfuscateId::Coder).to receive(:encode).and_return(100)
      allow_any_instance_of(ActiveRecordObfuscateId::Coder).to receive(:decode).and_return(1)
    end

    it 'assign value from aggregation' do
      expect(User.new(id: 1).id).to eq(1)
      expect(User.new(obfuscated_id: 100).id).to eq(1)
    end

    it 'calculates value with aggregation' do
      expect(User.new(id: 1).obfuscated_id).to eq(100)
      expect(User.new(obfuscated_id: 100).id).to eq(1)
    end

    it 'converts value from "1".to_obfuscated_id' do
      expect(User.where(id: 1).to_sql).to match(/"id" = 1/)
      expect(User.where(obfuscated_id: 100).to_sql).to match(/"id" = 1/)

      expect(Cart.where(obfuscated_user_id: 100).to_sql).to match(/"user_id" = 1/)
      expect(Cart.joins(:user).merge(User.where(obfuscated_id: 100)).to_sql).to match(/"users"."id" = 1/)
    end

    it 'defines #obfuscated_xxx' do
      expect(User.new(obfuscated_id: 1).obfuscated_id).to eq(100)
    end
  end
end
