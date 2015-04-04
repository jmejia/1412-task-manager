require 'yaml/store'
require 'sequel'
require 'byebug'

class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager_development.sqlite3")
    end
  end

  def self.create(task)
    data = {"title" => task[:title], "description" => task[:description]}
    dataset.insert(data)
  end

  def self.all
    dataset.all.map do |raw_task|
      Task.new(raw_task)
    end
  end

  def self.find(id)
    raw_task = dataset.find(id).first
    Task.new(raw_task)
  end

  def self.delete_all
    dataset.delete
  end

  private

  def self.dataset
    database.from(:tasks)
  end
end
