require 'rspec'
require 'pg'
require 'lists'
require 'spec_helper'

describe List do
  it 'is initialized with a name' do
    list = List.new('Epicodus stuff', 2)
    list.should be_an_instance_of List
  end

  it 'tells you its name' do
    list = List.new('Epicodus stuff', 2)
    list.name.should eq 'Epicodus stuff'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new('Epicodus stuff', 1)
    list2 = List.new('Epicodus stuff', 1)
    list1.should eq list2
  end

  it 'starts off with no lists' do
    List.all.should eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('learn SQL', 2)
    list.save
    List.all.should eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new('learn SQL', 2)
    list.save
    list.id.should be_an_instance_of Fixnum
  end

  it 'can be initialized with its database ID' do
    list = List.new('Epicodus stuff', 1)
    list.should be_an_instance_of List
  end

  it 'returns the name of a list when given its id' do
    list = List.new('Epicodus stuff', 1)
    list.save
    List.find(list.id).should eq list
  end

  it 'returns the tasks for a given list' do
    list = List.new('Epicodus stuff', 1)
    task1 = Task.new('stuff', 1)
    task2 = Task.new('more stuff', 1)
    task1.save
    task2.save
    list.tasks.should eq [task1, task2]
  end
end
