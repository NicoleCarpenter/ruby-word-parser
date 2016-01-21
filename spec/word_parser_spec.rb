require 'spec_helper'

describe WordParser do
  text1 = "sample_texts/sample_text.txt"
  text2 = "sample_texts/sample_text2.txt"
  text3 = "sample_texts/symbols.txt"
  text4 = "sample_texts/glaciers.txt"

  let(:parser){WordParser.new(text1, text2, text3)}

  describe '#load_files' do
    it 'should return an array with each of the full text files' do
      expect(parser.load_files).to be_an(Array)
      expect(parser.text.count).to eq(3)
    end
  end

  describe '#separate_words' do
    it 'should split the combined texts to individual words' do
      expect(parser.separate_words).to be_an(Array)
    end
    it 'should split words on non-word characters' do
      expect(parser.separate_words).not_to include("?", "!", "@", "#", "$", "%", "&", "*", "(", ")", "-", "~", "`", "+", "=", "{", "}", "[", "]", "|", "\\", ":", ";", "\"", "\'", "<", ">", ",", ".", "/")
    end
    it 'should split words on underscores' do
      expect(parser.separate_words).not_to include("_")
    end
  end

  describe '#standardize_case' do
    context 'capitalized word other than I' do
      it 'should return words in lower case' do
        words = ["Hello", "WORLD"]
        expect(parser.standardize_case(words)).to eq(["hello", "world"])
      end
    end
    context 'not capitalized words' do
      it 'should not change the words' do
        words = ["hello", "world"]
        expect(parser.standardize_case(words)).to eq(words)
      end
    end
    context '"I"' do
      it 'should not change I to lower case' do
        words = ["I"]
        expect(parser.standardize_case(words)).to eq(words)
      end
    end
  end

  describe '#remove_empty_chars' do
    it 'should not include any blank words' do
      words = ["Hello", "", "world"]
      expect(parser.remove_empty_chars(words)).not_to include("")
      expect(parser.remove_empty_chars(words)).to eq(["Hello", "world"])
    end
    it 'should not include any new line characters' do
      words = ["Hello", "", "world", "n", "Hello", "", "again", "", "world"]
      expect(parser.remove_empty_chars(words)).not_to include("n")
      expect(parser.remove_empty_chars(words)).to eq(["Hello", "world", "Hello", "again", "world"])
    end
    it 'should not include any carriage return characters' do
      words = ["Hello", "", "world", "r", "Hello", "", "again", "", "world"]
      expect(parser.remove_empty_chars(words)).not_to include("n")
      expect(parser.remove_empty_chars(words)).to eq(["Hello", "world", "Hello", "again", "world"])
    end
    it 'should not include any tab characters' do
      words = ["Hello", "", "world", "t", "Hello", "", "again", "", "world"]
      expect(parser.remove_empty_chars(words)).not_to include("n")
      expect(parser.remove_empty_chars(words)).to eq(["Hello", "world", "Hello", "again", "world"])
    end
  end

  describe '#get_frequency' do
    words = ["hurricane", "nicole", "was", "the", "last", "hurricane", "in", "the", "1998", "atlantic", "hurricane", "season", "it", "developed", "from", "a", "frontal", "low", "to", "the", "south", "of", "the", "azores", "on", "november", "24", "and", "quickly", "strengthened", "to", "reach", "winds", "of", "70", "mph", "110", "km", "h", "as", "it", "moved", "to", "the", "west", "southwest"]
    it 'should return a Hash' do
      expect(parser.get_frequency(words)).to be_a(Hash)
    end
    it 'should return each word only once' do
      expect(parser.get_frequency(words).length).to eq(words.uniq.length)
    end
    it 'should return the words as keys' do
      expect(parser.get_frequency(words).keys).to eq(words.uniq)
    end
    it 'should return the frequencies as values' do
      words = ["hurricane", "nicole", "hurricane", "nicole", "hurricane", "banana", "banana"]
      expect(parser.get_frequency(words).values.first).to eq(3)
      expect(parser.get_frequency(words).values.last).to eq(2)
    end
  end

  describe '#sort_by_frequency' do
    words = ["nicole", "hurricane", "hurricane", "nicole", "hurricane", "banana", "hurricane"]
    it 'should list the items that occur most frequently, first' do
      frequency = parser.get_frequency(words)
      expect(parser.sort_by_frequency(frequency)[0][0]).to eq("hurricane")
    end
    it 'should list the item that occurs least frequently, last' do
      frequency = parser.get_frequency(words)
      expect(parser.sort_by_frequency(frequency)[-1][0]).to eq("banana")
    end
  end

  describe '#get_results' do
    it 'should return ten results' do
      expect(parser.get_results.length).to eq(10)
    end
    it 'should return the results in numeric order, with most frequent entry first' do
      expect(parser.get_results[0][0]).to be > (parser.get_results[-1][0])
    end
    context 'text 1' do
      it 'should return the top ten from text 1' do
        parser = WordParser.new(text1)
        expect(parser.get_results).to eq([["the", 33], ["of", 21], ["to", 12], ["it", 11], ["and", 11], ["in", 10], ["a", 10], ["that", 8], ["what", 7], ["was", 7]])
      end
    end
    context 'text 2' do
      it 'should return the top ten from text 1' do
        parser = WordParser.new(text2)
        expect(parser.get_results).to eq([["the", 166], ["and", 103], ["a", 92], ["to", 76], ["of", 65], ["that", 61], ["it", 47], ["he", 42], ["I", 37], ["s", 36]])
      end
    end
    context 'texts 1 & 2' do
      it 'should return the top ten from text 1' do
        parser = WordParser.new(text1, text2)
        expect(parser.get_results).to eq([["the", 199], ["and", 114], ["a", 102], ["to", 88], ["of", 86], ["that", 69], ["it", 58], ["in", 45], ["I", 43], ["he", 42]])
      end
    end
    context 'text4' do
      it 'should return the top ten from text 1' do
        parser = WordParser.new(text4)
        expect(parser.get_results).to eq([["the", 872], ["of", 494], ["and", 358], ["a", 253], ["to", 209], ["in", 182], ["is", 169], ["or", 133], ["glacier", 108], ["with", 99]])
      end
    end
  end
end