require 'rspec'
require 'pg'
require 'tasks'
require 'spec_helper'

describe Task do
  it 'is initialized with a name' do
    task = Task.new('learn SQL', 0)
    task.should be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('learn SQL', 0)
    task.name.should eq 'learn SQL'
  end

  it 'tells you its list ID' do
    task = Task.new('learn SQL', 0)
    task.list_id.should eq 0
  end

  it 'starts off with no tasks' do
    Task.all.should eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL', 0)
    task.save
    Task.all.should eq [task]
  end

  it 'is the same task if it has the same name and ID' do
    task1 = Task.new('learn SQL', 0)
    task2 = Task.new('learn SQL', 0)
    task1.should eq task2
  end

  it 'deletes a task when the name is entered' do
    task1 = Task.new('learn SQL', 0)
    task2 = Task.new('sweep floors', 0)
    task1.save
    task2.save
    task1.delete_task(task1.name)
    Task.all.should eq [task2]
  end

end
