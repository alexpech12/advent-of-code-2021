# Advent of Code 2021

## Day 1 - ⭐⭐
This was a fun little activity to practice some Ruby one-liners. I think I'd learnt from last year the value of Ruby's `each_cons` method, so piecing this together was relatively straightforward.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/0dfe73a37ec85bea63c449138abfa81b698491ab/day1/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/0dfe73a37ec85bea63c449138abfa81b698491ab/day1/part2.rb)

## Day 2 - ⭐⭐
Sticking with short Ruby blocks for as long as I can. Managed to get Part 1 done pretty simply by just dividing up the array and summing parts together. Part 2 I went with the simplest solution conceptually, which was just to iterate through all the commands, updating the position, depth, and aim variables on each loop based on the current command. Nothing fancy there.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/96e200c8f37da24c085f0ae562550666ee66225c/day2/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/96e200c8f37da24c085f0ae562550666ee66225c/day2/part2.rb)

## Day 3 - ⭐⭐
Fun with recursion and Ruby block arguments!

I do feel like there should have been a better way to do 'count all the 1s in a column' than just iterating through the list. I think it's probably a sign that Ruby wasn't built for this kind of data processing.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/f616883fbf6ab217bf6d1bc0943a3a75637d81a0/day3/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/f616883fbf6ab217bf6d1bc0943a3a75637d81a0/day3/part2.rb)

## Day 4 - ⭐⭐
We're breaking out the classes and the regex!

This solution got me writing a simple class to represent a bingo board, and a regex to read the input. The regex was simple, and something I could've easily done with some `String#split` chains, but regex was briefer and I need the practice anyway.

Part 2 was a nice, simple modification of Part 1 (plus a small bug fix - turned out I was instantiating an additional empty BingoBoard instance). 

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/6634c13fd2c6db29212969bbd48ef0496d10f3fe/day4/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/6634c13fd2c6db29212969bbd48ef0496d10f3fe/day4/part2.rb)

## Day 5 - ⭐⭐
Making mistakes, and Ruby letting me down and making things difficult.

A couple of hiccups today. First, I tried implementing a solution where I could 'check' a point against any line and see if that point existed on the line. The logic was simpler, but it required two nested loops (I was looping through each point in the 2D array, and then within that looping through the collection of lines). This was fine for the example data (10 x 10 x 10 = 1000 iterations), but way too slow for the puzzle input (10 x 10 x 10 = 1000 iterations vs 1000 x 1000 x 500 = 500,000,000 iterations!). Once I reversed things so that I could just iterate through the lines and increment counters for the points they intersected things were much speedier.

Generating an array of points on a 2D grid from a start point and a end point in Ruby was easier said than done. The main difficulty is that Ruby Ranges don't support reverse ranges. So, generating points for a line segment like (1,2) -> (1,5) is simple - for example, `(2..5).to_a.map { |y| [x, y] }`. If the points are reversed though, (1,5) -> (1,2), you need to manually flip the order so that the code looks the same as above.

For diagonals it's even more difficult. (0,8) -> (8,0) can't just have the order of the arrays flipped. Either x or y is always going to be in reverse order. The solution I ended up opted for was to flag whether the points needed to be reversed, flip them the right way to create a Range and call `to_a`, then reverse my resulting array if it had previously been flipped. This is a lot of fuss just to generate two integer sequences and zip them together.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/7a31eb57198fc2f76ab9fda159e102f667b9b11f/day5/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/7a31eb57198fc2f76ab9fda159e102f667b9b11f/day5/part2.rb)

## Day 6 - ⭐⭐
Part 2 challenge here was pretty challenging, but simple once I'd figured out how to structure my solution.

For Part 1, I went with the obvious, iterative solution, which pretty much followed exactly how the problem was presented. I took the bait and subsequently struggled with Part 2 as my solution couldn't scale far enough.

I was stuck for a while thinking I needed to somehow mathematically model the exponential process, watching videos on modelling exponential growth.

When a better solution dawned on me, it seemed obvious - we don't need to track every individual fish, we just need to know how many there are of each timer value. Restructuring the code for Part 2 to do this instead got to the solution easily.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/1827d7f6053f6b5b03329699e1be63b12733c392/day6/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/1827d7f6053f6b5b03329699e1be63b12733c392/day6/part2.rb)
