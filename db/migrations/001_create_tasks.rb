require 'sequel'

database ||= Sequel.sqlite('db/task_manager_test.sqlite3')

database.create_table :tasks do
  primary_key :id
  String :title
  Text :description
end
