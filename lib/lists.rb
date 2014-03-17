require 'pg'

DB = PG.connect({:dbname => 'to_do'})

class List
  attr_reader(:name, :id)

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def ==(another_list)
    self.name == another_list.name && self.id == another_list.id
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id)
    end
    lists
  end

  def self.find(id)
    List.all.each do |list|
      if list.id == id
        return list
      end
    end
  end

  def tasks
    each_list_tasks = []
    results = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id};")
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      each_list_tasks << Task.new(name, list_id)
    end
    each_list_tasks
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end
end
