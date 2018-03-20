# frozen_string_literal: true

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  create_table(:users, force: true)
  create_table(:clearn_users, force: true)
end

class User < ActiveRecord::Base
end

class CleanUser < ActiveRecord::Base
end
