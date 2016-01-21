#Ruby Word Parser

Ruby Word Parser is a command-line indexer application that finds the top words across a collection of documents. The application returns the most used words and the frequency in which each occurs:

```ruby
  WORD          |  FREQUENCY
----------------+-------------
  the                 872
  of                  494
  and                 358
  a                   253
  to                  209
  in                  182
  is                  169
  or                  133
  glacier             108
  with                 99
------------------------------
```

##Requirements

This is a terminal based application using Ruby(2.2.1). Unit testing is accomplished with Rspec.

The application can be run from within the main directory by running the `ruby runner.rb` file. The command `rspec spec/*` will run tests for all classes.

Users can opt to send one or more files to the application as command line arguments (`ARGV`) by including the file path after calling the runner: `ruby runner.rb file1.txt file2.txt`.


##Limitations

- The application produces 10 results, however if there is a tie at the tenth place, the results will not be accurately represented. The results are displayed in reverse alphabetical order which is not a meaningful qualification for not making the cutoff.

- Words are delimited by all punctuation, including hyphens (-) and apostrophes ('). This means that contractions will be split into two separate words that may not be full words: `"don't" => ["don", "t"]`, `"you're" => ["you", "re"]`.

- In its current form, only files with .txt extensions can be processed.

- Certain text characters are accounted for, such as `\n, \r` to account for non-text new-lines and carriage returns, however if joined with a natural word without a qualifying separation, the characters will be considered within the word boundary.

