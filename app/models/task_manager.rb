require 'yaml/store'
require 'byebug'

class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite('db/task_manager_test.sqlite3')
    else
      @database ||= YAML::Store.new("db/task_manager")
    end
  end

  def self.create(task)
    task_attributes = { title: task[:title], description: task[:description] }
    dataset.insert(task_attributes)
  end

  def self.all
    raw_tasks.map { |data| Task.new(data) }
  end

  def self.find(id)
    Task.new(raw_task(id))
  end

  def self.update(id, task)
    database.transaction do
      target = database['tasks'].find { |data| data["id"] == id }
      target["title"] = task[:title]
      target["description"] = task[:description]
    end
  end

  def self.delete(id)
    database.transaction do
      database['tasks'].delete_if { |task| task["id"] == id }
    end
  end

  def self.delete_all
    dataset.delete
  end

  private

  def self.dataset
    database[:tasks]
  end

  def self.raw_task(id)
    dataset.where(:id => id).first
  end

  def self.raw_tasks
    dataset.to_a
  end
end
