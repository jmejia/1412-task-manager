require_relative '../../app/models/task_manager'

environments = %w(development test)

environments.each do |env|
  Sequel.sqlite("db/task_manager_#{env}.sqlite3").create_table :tasks do
    primary_key :id
    String :title
    String :description

    puts "created tasks table in db/task_manager_#{env}.sqlite3"
  end
end
