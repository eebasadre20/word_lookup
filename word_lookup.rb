class WordLookup
  def initialize(file_path, target_word)
    @file_path = file_path
    @target_word = target_word
    @freq = Hash.new(0)
  end

  # Total points target word points + regular alphabet points
  def total_points
    file = File.open(file_path, 'r')
    total_regular_alphabet_points(letters_frequency(file))
  end

  # 5 points on each letter in target word
  # def target_word_points
  #   file = File.open(file_path, 'r')
  #   total_regular_alphabet_points(letters_frequency(file))
  # end

  # There's a corresponding points on each letter in regular alphabet
  # A = 0, B = 1, C = 2, D = 3, E = 4, F = 0, ...
  # def regular_alphabet_points
  #   file = File.open(file_path, 'r')
  #   letters = letters_frequency(file)
  #   total_regular_alphabet_points(letters)
  # end

  private
  attr_reader :file_path, :target_word, :freq

  def letters_frequency(target)
    target.each_char
        .lazy
        .grep(/[[:alpha:]]/)
        .map(&:upcase)
        .each_with_object(freq) do |char, freq_map|
          freq_map[char] += 1
    end
  end

  def points_per_alphabet
    alpha_freq = Hash.new(0)
    current_points = 0

    ('a'..'z')
      .map(&:upcase)
      .each_with_object(alpha_freq) do | char, freq_map|
      current_points = 0 if current_points > 4
      freq_map[char] = current_points
      current_points = current_points + 1
    end

  end

  def total_target_word
    File.foreach(file_path)
        .reduce(0) do |cnt, line|
          cnt + line.scan(/\b#{target_word}\b/i).count
    end
  end

  def total_regular_alphabet_points(letters)
    points_per_alpha = points_per_alphabet

    letters.reduce(0) do |cnt, letter|
      key = letter[0]
      num_of_occurrence = letter[1]
      next unless points_per_alpha.has_key? key


      cnt = cnt + (points_per_alpha[key] * num_of_occurrence)
      cnt = cnt + (5 * num_of_occurrence) if target_word.upcase.include? key
      cnt
    end
  end
end
