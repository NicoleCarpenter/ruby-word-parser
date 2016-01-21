LIMIT = 10      # number of entries to display

require_relative 'ui'

class WordParser
  attr_reader :files, :text, :words, :ui

  def initialize(*args)
    @ui = UI.new
    @files = args
    @text = load_files
    @words = []
  end

  def load_files
    @ui.confirm_valid_files(@files.flatten)
    @files.flatten.map do |file|
      File.open(file, 'r') { |f| f.read }
    end
  end

  def separate_words
    words = @text.to_s.split(/[\W, \_]/)
  end

  def standardize_case(words)
    words.map do |word|
      if word != "I"
        word.downcase
      else
        word
      end
    end
  end

  def remove_empty_chars(words)
    words.reject{|element| element == "" || element == "n" || element == "r" || element == "t"}
  end

  def get_frequency(words)
    words.inject(Hash.new(0)) {|hash,word| hash[word] += 1; hash }
  end

  def sort_by_frequency(frequencies)
    frequencies.sort_by{|element| element.reverse}.reverse
  end

  def get_results
    words = separate_words
    downcased_words = standardize_case(words)
    trimmed_words = remove_empty_chars(downcased_words)
    frequencies = get_frequency(trimmed_words)
    sorted_frequencies = sort_by_frequency(frequencies)
    sorted_frequencies[0..(LIMIT-1)]
  end

  def return_results
    results = get_results
    @ui.display_results(results, @files)
  end
end