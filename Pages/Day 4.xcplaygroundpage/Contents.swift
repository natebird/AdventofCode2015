//: [Table of Contents](Table of Contents)

/*:

[http://adventofcode.com/day/3](http://adventofcode.com/day/3)

### Day 4: The Ideal Stocking Stuffer ---

Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts for all the economically forward-thinking little girls and boys.

To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given below) followed by a number in decimal. To mine AdventCoins, you must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

For example:

If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.
If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....

### --- Part Two ---

Now find one that starts with six zeroes.

[Table of Contents](Table of Contents) | [Continue to Day 5](@next)
*/

import Foundation

func md5hash(string: String) -> String
{
  let t = NSTask()
  t.launchPath = "/sbin/md5"
  t.arguments = ["-q", "-s", string]
  t.standardOutput = NSPipe()
  
  t.launch()
  
  let outData = t.standardOutput.fileHandleForReading.readDataToEndOfFile()
  var outBytes = [UInt8](count:outData.length, repeatedValue:0)
  outData.getBytes(&outBytes, length: outData.length)
  
  var outString = String(bytes: outBytes, encoding: NSASCIIStringEncoding)
  
  assert(outString != nil, "failed to md5 input string")
  
  return outString!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

func mineAdventCoins(input: String, prefix: String) -> Int {
  var i = 0

  while true {
    if "\(input)\(i)".md5.hasPrefix(prefix) {
      return i
    }
    i += 1
  }
}

let input = NBFileManager.shared.loadStringInputFromResource("day3") // use "day3-quick" for development

mineAdventCoins(input, prefix: "00000")
mineAdventCoins(input, prefix: "000000")