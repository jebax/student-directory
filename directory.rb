# student names are stored in an array.
def input_students
  students = []
  puts "Enter a student name. To finish, press enter without entering a name."

  while name = gets.chomp
    break if name.empty?
    students << {name: name, cohort: :november, nationality: :English, height: "189cm"}
    puts "Now we have #{students.count} student(s)."
  end

  students
end

def print_header
  puts "The students of Villains Academy".center(60)
  puts "-----------------------".center(60)
end

def print(students)
  count = 1
  until count > students.size do
    current = students[count - 1]
    puts "#{count}. #{current[:name]} (#{current[:cohort]} cohort, #{current[:nationality]}, #{current[:height]})."
    count += 1
  end
end

def print_specific_initial(students, initial)
  selected = students.select do |student|
    student[:name].chars.first.downcase == initial.downcase
  end
  selected.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, #{student[:nationality]}, #{student[:height]})."
  end
end

def print_specific_length(students, length)
  selected = students.select do |student|
    student[:name].size <= length
  end
  selected.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, #{student[:nationality]}, #{student[:height]})."
  end
end

def print_footer(students)
  case students.size
  when 0 then puts "There are no students!".center(60)
  when 1 then puts "We only have one student, but they're great!".center(60)
  else puts "Overall, we have #{students.count} great students.".center(60)
  end
end

students = input_students
