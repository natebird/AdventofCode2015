//: [Table of Contents](Table of Contents)

/*:

[http://adventofcode.com/day/3](http://adventofcode.com/day/3)

### --- Day 3: Perfectly Spherical Houses in a Vacuum ---

Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

For example:

> delivers presents to 2 houses: one at the starting location, and one to the east.
^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.

### --- Part Two ---

The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

This year, how many houses receive at least one present?

For example:

^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.

[Table of Contents](Table of Contents) | [Continue to Day 4](@next)
*/

import Foundation

struct SantaMapPoint {
  var x: Int = 0
  var y: Int = 0
  
  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
  
  func key() -> String {
    return "\(x), \(y)"
  }
  
  mutating func move(direction: Character) -> String {
    switch direction {
    case "^": y += 1
    case ">": x += 1
    case "v": y -= 1
    case "<": x -= 1
    default: break
    }
    return "\(x), \(y)"
  }
}

let input = NBFileManager.shared.loadStringInputFromResource("day3") // use "day3-quick" for development

// track houses visited
var housesVisitedFirstYear = [String: Bool]()
var housesVisitedSecondYear = [String: Bool]()

// starting position coordinates
var santaPosition = SantaMapPoint(x: 0, y: 0)
var robotPosition = SantaMapPoint(x: 0, y: 0)

// Add starting positions
housesVisitedFirstYear[santaPosition.key()] = true
housesVisitedSecondYear[santaPosition.key()] = true
housesVisitedSecondYear[robotPosition.key()] = true

// Count houses visited by Santa the first year
for (index, item) in input.characters.enumerate() {
  housesVisitedFirstYear[santaPosition.move(item)] = true
}

// Count houses visited by both the second year
for (index, item) in input.characters.enumerate() {
  if index % 2 == 0 {
    housesVisitedSecondYear[santaPosition.move(item)] = true
  } else {
    housesVisitedSecondYear[robotPosition.move(item)] = true
  }
}

print("Santa delivered presents to \(housesVisitedFirstYear.count) houses the first year.")

print("Santa and his robot delivered presents to \(housesVisitedSecondYear.count) houses the second year.")
