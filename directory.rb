# student names are stored in an array.
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Patrick Bateman"
]

puts "The students of Villains Academy"
puts "-------------"
students.each { |student| puts student }

puts "Overall, we have #{students.count} great students."
