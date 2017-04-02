# Robot Coding Test

This is a coding assignment, for more details please see [CodingTest-Robots.pdf](CodingTest-Robots.pdf)

## Get Started

Make sure you've installed ruby 2.3.1, if not, if not, please follow this [link](https://www.ruby-lang.org/en/documentation/installation/) to install.

### Install

```sh
git clone https://github.com/wayne5540/robot-test.git robot
cd robot
bundle install
```

### Run robot

#### Input from terminal

```sh
ruby app/main.rb
```

#### Input from file

```sh
cat commands.txt | ruby app/main.rb
```

### Usage

Play with the robot

Valid commands: `PLACE`, `MOVE`, `LEFT`, `RIGHT`, `REPORT`

* `PLACE`
  * `PLACE` places your robot on the table
  * `PLACE` takes 3 arguments: cordinate_x, cordinate_y, orientation
  * Argument constraints:
    * (cordinate_x/cordinate_y) should be a number
    * orientation should be `NORTH`, `SOUTH`, `EAST`, or `WEST`
  * Ex: `PLACE 1,2,NORTH` => no output

* `MOVE`
  * `MOVE` moves one step forward depends on the orientation your robot is facing
  * `MOVE` takes no argument
  * `MOVE` only works if robot has been placed
  * Ex: `MOVE` => no output

* `LEFT`
  * `LEFT` turns your robot face to left
  * `LEFT` takes no argument
  * `LEFT` only works if robot has been placed
  * Ex: `LEFT` => no output

* `RIGHT`
  * `RIGHT` turns your robot face to right
  * `RIGHT` takes no argument
  * `RIGHT` only works if robot has been placed
  * Ex: `RIGHT` => no output

* `REPORT`
  * `REPORT` outputs your robot's current position and orientation formated as (cordinate_x,cordinate_y,orientation)
  * `REPORT` takes no argument
  * `REPORT` only works if robot has been placed
  * Ex: `REPORT` => output: "1,2,NORTH"


### Example

#### Example 1 - Basic simulation

```
$ ruby toy_robot/toy_robot.rb
PLACE 1,2,NORTH
MOVE
LEFT
MOVE
REPORT
Output: `0,3,WEST`
```


#### Example 2 - Ignores invalid command

```
$ ruby toy_robot/toy_robot.rb
PLACE 1,2,NORTH
MOVE
MOVE
MOVE
MOVE
MOVE
REPORT
Output: `0,4,NORTH`
```

## Running Test

Run `rspec` command from terminal and you'll see the test result. (make sure you had ran `bundle install` first)

## Licence

[WTFPL](http://www.wtfpl.net/)
