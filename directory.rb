@students = []
@students_current = []

def interactive_menu
  load_title
  loop do
    print_menu
    process(gets.chomp)
  end
end

def load_title
  puts File.read("title.txt")
  puts "\n"
end

def print_menu
  puts "Enter an option number, followed by the return key".center(100)
  puts "-----------------------".center(100)
  puts "1. Input students".center(100)
  puts "2. List all students".center(100)
  puts "3. Save students to a file".center(100)
  puts "4. Load student information".center(100)
  puts "9. Exit".center(100)
end

def process(selection)
  case selection
    when "1"
      @students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  while true do
    puts "Enter a student name. To finish, press return now."
    name = gets.chomp
    break if name.empty?
    @students_current << { name: name, cohort: nil, nationality: nil, age: nil }
    @student = @students_current[-1]
    get_information
    students_count_check
  end
  @students_current
end

def get_information
  get_cohort
  get_nationality
  get_age
end

def get_cohort
  while true do
    puts "Enter a cohort. To enter the default cohort (November), press return."
    cohort = gets.chomp
    if cohort.empty?
      @student[:cohort] = :November
      break
    else
      @student[:cohort] = cohort.to_sym
    end
    break if typo_check(cohort)
  end
end

def get_nationality
  while true do
    puts "Enter a nationality. To enter the default value (N/A), press return."
    nationality = gets.chomp
    if nationality.empty?
      @student[:nationality] = "N/A"
      break
    else
      @student[:nationality] = nationality
    end
    break if typo_check(nationality)
  end
end

def get_age
  while true do
    puts "Enter an age in years. To enter the default value (N/A), press return."
    age = gets.chomp
    if age.empty?
      @student[:age] = "N/A"
      break
    else
      @student[:age] = age
    end
    break if typo_check(age)
  end
end

def typo_check(input)
  puts "Is #{input} correct? Type 'no' to re-enter, or anything else to continue."
  input = gets.chomp
  input != "no"
end

def students_count_check
  if @students_current.size == 1
    puts "Now we have 1 student."
  else
    puts "Now we have #{@students_current.size} students."
  end
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def print_header
  puts "The students of Joel's Academy".center(100)
  puts "-----------------------".center(100)
end

def print_students_list(students)
  puts "No students to print!\n".center(100) if students.size == 0
  cohorts = group_by_cohort(students)
  group_print(cohorts)
end

def group_by_cohort(students)
  students.each_with_object({}) do |student, hash|
    hash[student[:cohort]] ||= []
    hash[student[:cohort]] << student
  end
end

def group_print(groups)
  groups.each do |cohort, students|
    puts "#{cohort} cohort:".center(100)
    students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:nationality]}, age #{student[:age]}).".center(100)
    end
    puts "\n"
  end
end

def print_footer(students)
  case students.size
  when 0 then puts "There are no students!\n".center(100)
  when 1 then puts "We only have one student, but they're great!\n".center(100)
  else puts "Overall, we have #{students.count} great students.\n".center(100)
  end
end

def print_specific_initial(students, initial)
  selected = students.select do |student|
    student[:name].chars.first.downcase == initial.downcase
  end
  selected.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, #{student[:nationality]}, age #{student[:age]}).".center(100)
  end
end

def print_specific_length(students, length)
  selected = students.select do |student|
    student[:name].size <= length
  end
  selected.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, #{student[:nationality]}, age #{student[:age]}).".center(100)
  end
end

def save_students
  puts "Please enter a file name: "
  input = gets.chomp
  file = File.open("#{input}.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:nationality], student[:age]]
    line = student_data.join(", ")
    file.puts line
  end
  file.close
  puts "Write to #{input}.csv complete!"
end

def load_students
  puts "Please enter a file name, including extension: "
  input = gets.chomp
  file = File.open("#{input}", "r")
  file.readlines.each do |line|
  name, cohort, nationality, height = line.chomp.split(',')
    @students << { name: name, cohort: cohort.to_sym, nationality: nationality, age: age }
  end
  file.close
  puts "Load complete!"
end

interactive_menu
