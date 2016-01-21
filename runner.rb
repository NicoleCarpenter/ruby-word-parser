require_relative 'word_parser'

text1 = "sample_texts/sample_text.txt"
text2 = "sample_texts/sample_text2.txt"
text3 = "sample_texts/symbols.txt"
text4 = "sample_texts/glaciers.txt"


if ARGV.any?
  files = ARGV[0..-1]
  parser = WordParser.new(files)
else
  parser = WordParser.new(text1, text2, text3, text4)
end

parser.return_results
