# frozen_string_literal: true

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  create_table(:users, force: true)

  create_table(:carts, force: true) do |t|
    t.references(:user)
  end
end

class User < ActiveRecord::Base
  has_many(:carts)
end

class Cart < ActiveRecord::Base
  belongs_to(:user)
end
