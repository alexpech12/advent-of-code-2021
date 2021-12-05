class BingoBoard
  attr_reader :rows

  def initialize
    @rows = []
  end

  def add_row(row)
    rows << row
  end

  def rows_and_columns
    rows + rows.transpose
  end

  def winner?(numbers)
    rows_and_columns.any? { |line| (line - numbers).empty? }
  end
end

File.open(ARGV[0], 'r') do |f|
  boards = []
  numbers = f.readline.scan(/\d+/).map(&:to_i)

  loop do
    board = BingoBoard.new
    boards << board

    f.readline
    5.times.each do
      board.add_row f.readline.scan(/\d+/).map(&:to_i)
    end
  rescue EOFError
    puts "Done"
    break
  end

  winner = nil
  winning_numbers = nil
  (4..(numbers.length-1)).each do |i|
    winner = boards.find { |board| board.winner?(numbers[0..i]) }
    if winner
      winning_numbers = numbers[0..i]
      break
    end
  end

  puts (winner.rows.flatten - winning_numbers).flatten.sum
  puts winning_numbers.last
  puts (winner.rows.flatten - winning_numbers).flatten.sum * winning_numbers.last
end
