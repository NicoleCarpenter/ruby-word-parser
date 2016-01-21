require 'spec_helper'

describe UI do
  let(:ui){UI.new}

  text1 = "sample_texts/sample_text.txt"
  text2 = "sample_texts/sample_text2.txt"
  text3 = "sample_texts/symbols.txt"
  text4 = "sample_texts/glaciers.txt"


  describe '#display_results' do
    xit 'should print results in a chart form' do
      results = [["the", 1071], ["of", 580], ["and", 472], ["a", 355], ["to", 297], ["in", 227], ["is", 177], ["or", 145], ["that", 139], ["it", 133]]
      files = [text1, text2, text3, text4]
      expect(ui.display_results(results, files)).to eq()
    end
  end

  describe '#list_files' do
    xit 'should print each file on a new line' do
      files = [text1, text2, text3, text4]
      expect(ui.list_files(files)).to eq("sample_texts/sample_text.txt\nsample_texts/sample_text2.txt\nsample_texts/symbols.txt\nsample_texts/glaciers.txt")
    end
  end
  describe '#list_results' do
    xit 'should print the results in line' do
      results = [["the", 1071], ["of", 580], ["and", 472], ["a", 355], ["to", 297], ["in", 227], ["is", 177], ["or", 145], ["that", 139], ["it", 133]]
      expect(ui.list_results(results)).to eq("  the                1071
  of                  580
  and                 472
  a                   355
  to                  297
  in                  227
  is                  177
  or                  145
  that                139
  it                  133 ")
    end
  end
end