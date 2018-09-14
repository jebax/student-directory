# student names are stored in an array.
def input_students
  students = []

  while true do
    puts "Enter a student name. To finish, press return once before entering a name, or twice at any other time."
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

  end

  students
end

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-----------------------".center(100)
end

def print(students)
  count = 1
  until count > students.size do
    current = students[count - 1]
    puts "#{count}. #{current[:name]} (#{current[:cohort]} cohort, #{current[:nationality]}, #{current[:height]}).".center(100)
    count += 1
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
