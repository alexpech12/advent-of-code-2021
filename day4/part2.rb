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
    f.readline

    board = BingoBoard.new
    boards << board

    5.times.each do
      board.add_row f.readline.scan(/\d+/).map(&:to_i)
    end
  rescue EOFError
    puts "Done"
    break
  end

  winners = []
  winning_numbers = nil
  (4..(numbers.length-1)).each do |i|
    current_winners = boards.find_all { |board| board.winner?(numbers[0..i]) }
    winners = (winners + current_winners).uniq
    if winners.length == boards.length
      winning_numbers = numbers[0..i]
      break
    end
  end

  last_board = winners.last

  puts (last_board.rows.flatten - winning_numbers).flatten.sum
  puts winning_numbers.last
  puts (last_board.rows.flatten - winning_numbers).flatten.sum * winning_numbers.last
end
