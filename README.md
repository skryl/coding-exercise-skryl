The Problem
===========
We want you to create a command-line application that will calculate the
ranking table for a hockey league.

Input/output
------------
The input and output will be text. Your solution should parse the provided
sample-input.txt file via stdin (pipe or redirect) or by parsing a file passed
by name on the command line. Your solution should output the correct result via
stdout to the console.

The input contains results of games, one per line. See sample-input.txt for
details. The output should be ordered from most to least points, following
(exactly) the format specified in expected-output.txt.

You can expect that the input will be well-formed. There is no need to add
special handling for malformed input files.

The rules
---------
In this league, a draw (tie) is worth 1 point and a win is worth 3 points. A
loss is worth 0 points. If two or more teams have the same number of points,
they should have the same rank and be printed in alphabetical order (as in the
tie for 3rd place in the sample data).

Guidelines
-----------
This should be implemented in a language with which you are familiar. We would
prefer that you use ruby or javascript, if you are comfortable doing so. If none
of these are comfortable, please choose a language that is both comfortable for
you and suited to the task.

Your solution should be able to be run (and if applicable, built) from the
command line. Please include appropriate scripts and instructions for
running your application and your tests.

If you use other libraries installed by a common package manager
(rubygems/bundler, npm, etc), it is not necessary to commit the
installed packages.

We write automated tests and we would like you to do so as well.

We appreciate well factored, object-oriented or functional code.

Please document any steps necessary to run your solution and your tests.

Platform support
----------------
This will be run in a unix-ish environment (OS X). If you choose to use a
compiled language, please keep this in mind. (Dependency on Xcode is acceptable
for objective-c solutions) Please use platform-agnostic constructs where
possible (line-endings and file-path-separators are two problematic areas).

Submission
----------
Please submit your solution by pushing up a branch to your Github repo and open a PR. Add Github users `amay` and `eagsalazar` as reviewers.




The Solution
===========

Dependencies
-----------
The solution relies on the `thor` and `rspec` gems, please install them first

```
bundle install
```

Summary
-----------
The solution consists of three files:

1. The `Ranking` class `ranking.rb` where the logic resides
2. The CLI runner `rank` which is responsible for the command line interface
3. The spec file `ranking_spec.rb` which contains the tests for the `Ranking` class


Usage
-----------
Calling rank with no arguments will print the script usage summary
```
./rank

Commands:
  rank help [COMMAND]  # Describe available commands or one specific command
  rank tabulate        # tabulate rankings from game data
```

Calling a command with `-h` will print the command usage summary
```
./rank tabulate -h

Usage:
  rank tabulate

Options:
  i, [--input=INPUT]    # input  filename
  o, [--output=OUTPUT]  # output filename

tabulate rankings from game data
```

Running
-----------
Running with stdin/stdout

```
cat sample-input.txt | rank t > output.txt
```

Running with input/output files
```
./rank t -i sample-input.txt -o output.txt
```

Running with an input file and printing to stdout
```
./rank t -i sample-input.txt
```

Testing
-----------
```
rspec .
```

Fun
-----------
I thought it would be fun to compare the output of our rankings algorithm to
actual NHL rankings for the 2016-2017 season.

Sources:
- [2016-2017 NHL Games](https://www.hockey-reference.com/leagues/NHL_2017_games.html)
- [2016-2017 NHL Standings](https://www.hockey-reference.com/leagues/NHL_2017_standings.html)

You can run the script on the dataset yourself with the following command

`./rank t -i nhl2016-2017.txt`

which results in the following rankings

```
1. Washington Capitals, 165 pts
2. Pittsburgh Penguins, 150 pts
2. Columbus Blue Jackets, 150 pts
2. Chicago Blackhawks, 150 pts
5. Minnesota Wild, 147 pts
6. New York Rangers, 144 pts
7. Edmonton Oilers, 141 pts
8. Montreal Canadiens, 139 pts
9. San Jose Sharks, 138 pts
9. Anaheim Ducks, 138 pts
9. St. Louis Blues, 138 pts
12. Calgary Flames, 135 pts
13. Ottawa Senators, 132 pts
13. Boston Bruins, 132 pts
15. Tampa Bay Lightning, 126 pts
16. New York Islanders, 123 pts
16. Nashville Predators, 123 pts
18. Toronto Maple Leafs, 120 pts
18. Winnipeg Jets, 120 pts
20. Philadelphia Flyers, 117 pts
20. Los Angeles Kings, 117 pts
22. Carolina Hurricanes, 108 pts
23. Florida Panthers, 105 pts
24. Dallas Stars, 102 pts
25. Detroit Red Wings, 99 pts
25. Buffalo Sabres, 99 pts
27. Arizona Coyotes, 90 pts
27. Vancouver Canucks, 90 pts
29. New Jersey Devils, 84 pts
30. Colorado Avalanche, 67 pts
```

they are close but not identical to the actual NHL standings, which
calculated using the following method:

```
Teams are awarded two points for each win, one point for each overtime or
shootout loss, and one point for each tie. Ties were eliminated as of the
2005-2006 NHL season, however.
```

```
01  Washington Capitalss   55-19-8
02  Pittsburgh Penguinss   50-21-11
03  Chicago Blackhawkss    50-23-9
04  Columbus Blue Jacketss 50-24-8
05  Minnesota Wilds        49-25-8
06  Anaheim Duckss         46-23-13
07  Edmonton Oilerss       47-26-9
08  Montreal Canadienss    47-26-9
09  New York Rangerss      48-28-6
10  San Jose Sharkss       46-29-7
11  St. Louis Bluess       46-29-7
12  Ottawa Senatorss       44-28-10
13  Boston Bruinss         44-31-7
14  Toronto Maple Leafss   40-27-15
15  Calgary Flamess        45-33-4
16  Tampa Bay Lightnings   42-30-10
17  Nashville Predatorss   41-29-12
18  New York Islanderss    41-29-12
19  Philadelphia Flyerss   39-33-10
20  Winnipeg Jetss         40-35-7
21  Carolina Hurricaness   36-31-15
22  Los Angeles Kingss     39-35-8
23  Florida Pantherss      35-36-11
24  Dallas Starss          34-37-11
25  Detroit Red Wingss     33-36-13
26  Buffalo Sabress        33-37-12
27  Arizona Coyotess       30-42-10
28  New Jersey Devilss     28-40-14
29  Vancouver Canuckss     30-43-9
30  Colorado Avalanches    22-56-4
```
