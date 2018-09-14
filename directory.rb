# student names are stored in an array.
def input_students
  students = []
  puts "Enter a student name. To finish, press enter without entering a name."

  while name = gets.chomp
    break if name.empty?
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} student(s)."
  end

  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students."
end

students = input_students
print_header
print(students)
print_footer(students)
