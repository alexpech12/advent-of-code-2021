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

## Day 7 - ⭐⭐
A nice, easy one today.

The solution could be easily implemented by just iterating through each possible position using a single nested loop.

Part 2 followed on smoothly from Part 1, requiring just a small tweak in how we were calculating fuel consumption.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/b9417e0bd70c414a51071fdd77df2a1f70950e09/day7/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/b9417e0bd70c414a51071fdd77df2a1f70950e09/day7/part2.rb)


## Day 8 - ⭐⭐
This was a fun little puzzle. Not too difficult, but it required a bit of time just to write everything out. A difficult one to do fast I think!

The trick for me was figuring out how to differentiate between 2 and 5 on the seven-segment display. All the other numbers contain a unique set of 1,4,7 and 8, which you can get right off the bat. For 2 and 5, you need to solve the other numbers first before you have enough information.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/1bf99d57200ec118eac7427d774724c602c8b549/day8/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/1bf99d57200ec118eac7427d774724c602c8b549/day8/part2.rb)

## Day 9 - ⭐⭐
Sets!

I found that using Sets (basically just an array with built-in uniqueness) was a convenient way to implement Part 2 today.

What we're essentially doing is an implementation of a [Flood Fill](https://en.wikipedia.org/wiki/Flood_fill) algorithm. I didn't use this as a reference while I was writing my code, but it's basically where I ended up. The basic idea was to keep track of the edges of the basin, and iteratively expand the basin by checking if those edges should be part of the basin and then pushing them into that set.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/8d8551ebff39c8a3108d4a3682d55391239f863c/day9/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/8d8551ebff39c8a3108d4a3682d55391239f863c/day9/part2.rb)

## Day 10 - ⭐⭐
Stacks!

At least, that's how I solved today's puzzle. The basic concept was that an open bracket means add that bracket to the stack, and a closing bracket means to pop one off. If the closing bracket doesn't match up to the top of the stack, we've found an error.

This worked really well, because it immediately gave me the expected vs actual bracket, and also the solution for Part 2 - the list of brackets that didn't get closed. This strategy made both parts straight-forward.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/148b66253242ed663d2a313e9fdb26c0200d701f/day10/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/148b66253242ed663d2a313e9fdb26c0200d701f/day10/part2.rb)

## Day 11 - ⭐⭐
More messing about with 2D arrays

I made a bit of a mess of this one. Lots of issues with the ordering that things were happening in (eg, incrementing things after they'd flashed, flashing things multiple times, etc).

There was a big Ruby gotcha that I got stuck on for a while. I was expecting something like `data[x]` to return `nil` if `x = -1`, because it's out of bounds. Unfortunately, for Ruby, `data[-1]` just returns the last element. So, for ages my answers were just _slightly_ off because my flashes were wrapping around at the edges.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/60ec85de730e3060fb0ffa92e9a4daf71709aa0e/day11/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/60ec85de730e3060fb0ffa92e9a4daf71709aa0e/day11/part2.rb)

## Day 12 - ⭐⭐
Recursion!

This one was fun. A few little gotchas, like needing to treat paths as bi-directional and figure out exactly how return values needed to look to stack up at the end.

As always, recursion is confusing at the best of times, but I used the stock-standard strategy of starting with the end conditions and working backwards, and things fell into place pretty easily.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/60ec85de730e3060fb0ffa92e9a4daf71709aa0e/day12/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/60ec85de730e3060fb0ffa92e9a4daf71709aa0e/day12/part2.rb)

## Day 13 - ⭐⭐
More 2D arrays

This one was theoretically quite simple. I think the main thing to notice was that we're always folding exactly in half, which makes combining 2D arrays easy. Nevertheless, there were a few things that tripped me up.

First, I'd assumed (incorrectly) that both the test data and the input data started the same way (folding along y). I'd noticed that the folds were always exactly in half, so I thought I could avoid needing to parse the instructions. It turned out this wasn't quite the case, because the test data started differently to the input. So, I ended up just needing to change my code as I moved from the test data to the input data. I've since gone back and cleaned up Part 2, but you can still see the original mess in [Part 1](https://github.com/alexpech12/advent-of-code-2021/blob/b006f03d35217ffb1ae506b602716ee37752c773/day13/part1.rb), and in [Part 2's commit history](https://github.com/alexpech12/advent-of-code-2021/blob/b006f03d35217ffb1ae506b602716ee37752c773/day13/part2.rb).

Second, I'd assumed (again, incorrectly) that there'd be data points along all edges of the paper, so I'd be able to determine the size of the page by looking for maximums. Again, this wasn't the case. Here at least I made use of where I'd noticed that we were always folding in half, so ultimately the first two folds were the basis for my overall dimensions.

[Part 1 solution](https://github.com/alexpech12/advent-of-code-2021/blob/1061e4cef59b805b30b66a760718847d00e7dcc4/day13/part1.rb)

[Part 2 solution](https://github.com/alexpech12/advent-of-code-2021/blob/1061e4cef59b805b30b66a760718847d00e7dcc4/day13/part2.rb)
