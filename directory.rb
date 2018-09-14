def input_students
  students = []

  # Students are added one by one, with each piece of information collected in order for each student.
  while true do
    puts "Enter a student name. To finish, press return now."
    name = gets.chomp
    break if name.empty?

    students << { name: name, cohort: nil, nationality: nil, height: nil }
    current = students[-1]

    while true do
      puts "Enter a cohort. To enter the default cohort (November), press return."
      cohort = gets.chomp
      if cohort.empty?
        current[:cohort] = :November
        break
      else
        current[:cohort] = cohort.to_sym
      end
      # The program allows for typos to be made, as the user can type 'no' to be allowed to enter the information again.
      puts "Is #{cohort} correct? Type 'no' to re-enter, or anything else to continue."
      input = gets.chomp
      break if input != "no"
    end

    while true do
      puts "Enter a nationality. To enter the default value (N/A), press return."
      nationality = gets.chomp
      if nationality.empty?
        current[:nationality] = "Undisclosed"
        break
      else
        current[:nationality] = nationality.to_sym
      end

      puts "Is #{nationality} correct? Type 'no' to re-enter, or anything else to continue."
      input = gets.chomp
      break if input != "no"
    end

    while true do
      puts "Enter a height in cm. To enter the default value (N/A), press return."
      height = gets.chomp
      if height.empty?
        current[:height] = "Undisclosed"
        break
      else
        current[:height] = "#{height}cm".to_sym
      end

      puts "Is #{height} correct? Type 'no' to re-enter, or anything else to continue."
      input = gets.chomp
      break if input != "no"
    end

    if students.size == 1
      puts "Now we have 1 student."
    else
      puts "Now we have #{students.size} students."
    end
  end
  # The method returns the `students` array at the end, for it to be used in other methods.
  students
end

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-----------------------".center(100)
end

def print(students)
  puts "No students to print!".center(100) if students.size == 0
  
  # Students are grouped by cohort: I create a new hash, extracting the cohort information to the hash.
  #   I then push each student's information into that cohort's key-value pair.
  cohorts = students.each_with_object({}) do |student, hash|
    hash[student[:cohort]] ||= []
    hash[student[:cohort]] << student
  end
  # For each cohort, I `puts` the name of the cohort, following by a numbered list of the students in that cohort, followed by an empty line.
  cohorts.each do |cohort, students|
    puts "#{cohort} cohort:".center(100)
    students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:nationality]}, #{student[:height]}).".center(100)
    end
    puts "\n"
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

def print_footer(students)
  case students.size
  when 0 then puts "There are no students!".center(100)
  when 1 then puts "We only have one student, but they're great!".center(100)
  else puts "Overall, we have #{students.count} great students.".center(100)
  end
end

students = input_students
print_header
print(students)
print_footer(students)
