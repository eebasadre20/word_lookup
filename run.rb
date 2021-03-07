require_relative 'word_lookup'

file_path = ARGV[0]
target_word = ARGV[1]

word_lookup = WordLookup.new(file_path, target_word)

# puts "Target word points - #{word_lookup.target_word_points}"
# puts "Regular alphabet points - #{word_lookup.regular_alphabet_points}"
puts "Total points - #{word_lookup.total_points}"