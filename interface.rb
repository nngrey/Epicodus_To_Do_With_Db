require './lib/lists'
require './lib/tasks'


def main_menu
  puts "To Do List"
  puts "--------------"
  puts "Press 'l' to create a new list"
  puts "Press 't' to view or add tasks"
  puts "Press 'x' to exit"
  user_input = gets.chomp
  if user_input == 'l'
    puts "Please enter the name of your list"
    list_name = gets.chomp
    new_list = List.new(list_name)
    new_list.save
    puts "You have created a new list named #{new_list.name}."
    main_menu
  elsif user_input == 't'
    List.all.each do |list|
      puts "#{list.id}. #{list.name}"
    end
    puts "Which list would you like to view or change?"
    list_choice = gets.chomp.to_i

    current_list = List.find(list_choice)

    # each_list_tasks = []
    # Task.all.each do |task|
    #   if task.list_id == list_choice
    #     each_list_tasks << task
    #   end
    # end
   current_list.tasks.each_with_index do |tsk, index|
      puts "#{index + 1}. #{tsk.name}"
    end

    puts "Press 'a' to add a task"
    puts "Press 'd' to delete a task"
    puts "Press 'm' to return to the main menu"
    edit_task = gets.chomp
    if edit_task == 'a'
      puts "Enter the name of the task"
      task_name = gets.chomp
      new_task = Task.new(task_name, list_choice)
      new_task.save
      puts "You have added the task '#{new_task.name}' to list '#{List.find(list_choice).name}'"
      main_menu
    elsif edit_task == 'd'
      puts "Which task would you like to delete?"
      option = gets.chomp.to_i
      puts "You have deleted the task '#{current_list.tasks[option - 1].name}' from list '#{List.find(list_choice).name}'"
      current_list.tasks[option - 1].delete_task(current_list.tasks[option - 1].name)
      main_menu
    elsif edit_task == 'm'
      main_menu
    end

  elsif user_input == 'x'
    puts "Goodbye"
  else
    main_menu
  end
end

main_menu
