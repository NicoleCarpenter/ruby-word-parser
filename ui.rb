class UI
  def display_results(results, files)
    puts "Top #{LIMIT} words from:"
    puts
    list_files(files)
    puts
    puts
    puts "  WORD             |  FREQUENCY  "
    puts "-------------------+-------------"
    list_results(results)
    puts "---------------------------------"
  end

  def list_files(files)
    files.each do |file|
      puts file
    end
  end

  def list_results (results)
    line_width = 16
    results.each do |result|
      puts ("  #{result[0]}").ljust(line_width) + ("#{result[1]} ").rjust(line_width)
    end
  end

  def confirm_valid_files(files)
    files.each do |file|
      unless File.file?(file)
        raise ArgumentError.new("Invalid file path")
      end
    end
  end
end