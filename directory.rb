require 'CSV'
@students = []
@students_current = []

def interactive_menu
  load_title
  loop do
    print_menu
    process(STDIN.gets.chomp)
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
  puts "3. List all students by cohort".center(100)
  puts "4. List all students with specific first initial".center(100)
  puts "5. Save students to a CSV file".center(100)
  puts "6. Load students from a specified CSV file".center(100)
  puts "0. Exit".center(100)
end

def process(selection)
  case selection
  when "1" then @students = input_students
  when "2" then show_students
  when "3" then show_cohorts
  when "4" then print_specific_initial(@students)
  when "5" then save_students
  when "6" then load_students("override")
  when "0" then exit
  else puts "I don't know what you mean, try again!"
  end
end

def input_students
  while true do
    puts "Enter a student name. To finish, press return now."
    name = STDIN.gets.chomp
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
    cohort = STDIN.gets.chomp
    if cohort.empty?
      @student[:cohort] = :November
      break
    else
      @student[:cohort] = cohort.to_sym
    end
    break unless typo_check(cohort)
  end
end

def get_nationality
  while true do
    puts "Enter a nationality. To enter the default value (N/A), press return."
    nationality = STDIN.gets.chomp
    if nationality.empty?
      @student[:nationality] = "N/A"
      break
    else
      @student[:nationality] = nationality
    end
    break unless typo_check(nationality)
  end
end

def get_age
  while true do
    puts "Enter an age in years. To enter the default value (N/A), press return."
    age = STDIN.gets.chomp
    if age.empty?
      @student[:age] = "N/A"
      break
    else
      @student[:age] = age
    end
    break unless typo_check(age)
  end
end

def typo_check(input)
  puts "Is #{input} correct? Type 'no' to re-enter, or anything else to continue."
  input = STDIN.gets.chomp
  input == "no"
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

def show_cohorts
  print_header
  print_cohorts_list(@students)
  print_footer(@students)
end

def print_header
  puts "The students of Joel's Academy".center(100)
  puts "-----------------------".center(100)
end

def print_cohorts_list(students)
  puts "No students to print!\n".center(100) if students.size == 0
  cohorts = group_by_cohort(students)
  group_print(cohorts)
end

def print_students_list(students)
  puts "No students to print!\n".center(100) if students.size == 0
  puts_each_student(students)
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
      puts "#{index + 1}. #{student[:name]} (#{student[:nationality]}, " \
      "age #{student[:age]}).".center(100)
    end
  end
end

def print_footer(students)
  case students.size
  when 0 then puts "There are no students!\n".center(100)
  when 1 then puts "We only have one student, but they're great!\n".center(100)
  else puts "Overall, we have #{students.count} great students.\n".center(100)
  end
end

def print_specific_initial(students)
  puts "Please enter an initial to list the relevant students: "
  initial = STDIN.gets.chomp
  selected = students.select do |student|
    student[:name].chars.first.downcase == initial.downcase
  end
  puts_each_student(selected)
end

def puts_each_student(students)
  count = 0
  current = students[count]
  while count < students.size do
    puts "#{count + 1}. #{current[:name]} (#{current[:cohort]} cohort, " \
    "#{current[:nationality]}, age #{current[:age]})".center(100)
    count += 1
  end
end

def save_students
  puts "Please enter a file name (without extension): "
  input = STDIN.gets.chomp
  CSV.open("#{input}.csv", "w") do |file|
    @students.each do |student|
      file << [student[:name],student[:cohort],student[:nationality],student[:age]]
    end
  end
  puts "Write to #{input}.csv complete!"
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}."
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(file = "students.csv")
  if file == "override"
    puts "Please enter a filename (without extension): "
    file = "#{STDIN.gets.chomp}.csv"
  end
  CSV.foreach("#{file}") do |row|
    @students << { name: row[0], cohort: row[1].to_sym, nationality: row[2], age: row[3] }
  end
  puts "Load successful!"
end

interactive_menu
