require_relative '../test_helper'

class TaskManagerTest < ModelTest
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description"})
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_it_returns_all_tasks
    task1 = TaskManager.create({title: "first task", description: "a description"})
    task2 = TaskManager.create({title: "second task", description: "a description"})
    tasks = TaskManager.all

    assert_equal "first task", tasks.first.title
    assert_equal "second task", tasks.last.title
  end
end
