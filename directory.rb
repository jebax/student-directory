@students = []
@students_current = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "Enter an option number, followed by the return key".center(100)
  puts "-----------------------".center(100)
  puts "1. Input the students".center(100)
  puts "2. Show the students".center(100)
  puts "9. Exit".center(100)
end

def process(selection)
  case selection
    when "1"
      @students = input_students
    when "2"
      show_students
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
    @students_current << { name: name, cohort: nil, nationality: nil, height: nil }
    @student = @students_current[-1]
    get_information
    students_count_check
  end
  @students_current
end

def get_information
  get_cohort
  get_nationality
  get_height
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
      @student[:nationality] = "Undisclosed"
      break
    else
      @student[:nationality] = nationality.to_sym
    end
    break if typo_check(nationality)
  end
end

def get_height
  while true do
    puts "Enter a height in cm. To enter the default value (N/A), press return."
    height = gets.chomp
    if height.empty?
      @student[:height] = "Undisclosed"
      break
    else
      @student[:height] = "#{height}cm".to_sym
    end
    break if typo_check(height)
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
  puts "The students of Villains Academy".center(100)
  puts "-----------------------".center(100)
end

def print_students_list(students)
  puts "No students to print!".center(100) if students.size == 0
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
      puts "#{index + 1}. #{student[:name]} (#{student[:nationality]}, #{student[:height]}).".center(100)
    end
    puts "\n"
  end
end

def print_footer(students)
  case students.size
  when 0 then puts "There are no students!".center(100)
  when 1 then puts "We only have one student, but they're great!".center(100)
  else puts "Overall, we have #{students.count} great students.".center(100)
  end
end

def print_specific_initial(students, initial)
  selected = students.select do |student|
    student[:name].chars.first.downcase == initial.downcase
  end
  selected.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, #{student[:nationality]}, #{student[:height]}).".center(100)
  end
end

def print_specific_length(students, length)
  selected = students.select do |student|
    student[:name].size <= length
  end
  selected.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort, #{student[:nationality]}, #{student[:height]}).".center(100)
  end
end

interactive_menu
