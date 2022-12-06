//
//  Day6.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/5/22.
//

import Foundation

class Day6: DayProtocol {
    var sampleInput: String = "day6sample.txt"
    var dayInput: String = "day6input.txt"

    func solvePart1(_ input: [Substring]) {
        solvePart(input, numDistinctChars: 4)
    }
    
    func solvePart2(_ input: [Substring]) {
        solvePart(input, numDistinctChars: 14)
    }
    
    func solvePart(_ input: [Substring], numDistinctChars: Int) {
        let line: Substring = input[0]
        for (idx, _) in input[0].enumerated() {
            let isUnique = areNextFourCharactersUnique(currentIndex: idx, line: line, distinctChars: numDistinctChars)
            if(isUnique) {
                print("Index: ", idx + numDistinctChars)
                return
            }
        }
    }
    
    func areNextFourCharactersUnique(currentIndex: Int, line: Substring, distinctChars: Int = 4) -> Bool{
        let start = line.index(line.startIndex, offsetBy: currentIndex)
        let end = line.index(line.startIndex, offsetBy: currentIndex+distinctChars)
        let range = start..<end
        let nextFour = line[range]
        let charSet = Set(nextFour)
        return charSet.count == distinctChars
    }
}
