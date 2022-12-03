//
//  Day3.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/2/22.
//

import Foundation

class Day3: DayProtocol {
    var sampleInput: String = "day3sample.txt"
    var dayInput: String = "day3input.txt"
    
    func day3() {
        let sampleInput: Array<Substring> = readSampleInput()
        let dayInput: Array<Substring> = readDayInput()
        
        solvePart1(sampleInput)
        solvePart1(dayInput)
        solvePart2(sampleInput)
        solvePart2(dayInput)
    }
    
    func solvePart1(_ input: Array<Substring>) {
        let contentTuples = splitSubstringsInHalf(input)
        let commonChars = findCommonChars(contentTuples)
        let values: [Int] = convertCharactersToUInt8Values(commonChars)
        let valueSum = values.reduce(0,+)
        
        print(valueSum)
    }
    
    func solvePart2(_ input: Array<Substring>) {
        let groups: [[Substring]] = groupElvesByThrees(input)
        let commonChars = findCommonCharsInGroupOfThree(groups)
        let sum = convertCharactersToUInt8Values(commonChars).reduce(0,+)
        print(sum)
    }
    
    func groupElvesByThrees(_ input: Array<Substring>) -> [[Substring]] {
        return input.filter{!$0.isEmpty}.chunked(into: 3)
    }
    
    func findCommonCharsInGroupOfThree(_ rucksackGroups: [[Substring]]) -> [Substring] {
        return rucksackGroups.map {
            rucksackGroup -> Substring in
            let rucksack0 = rucksackGroup[0].split(separator: "")
            let rucksack1 = rucksackGroup[1].split(separator: "")
            let rucksack2 = rucksackGroup[2].split(separator: "")
            return rucksack0.filter{char in rucksack1.contains(char) && rucksack2.contains(char)}.first!
        }
    }
    
    private func testCharToValueConversion() {
        let allChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split(separator: "")
        let allCharValues: [Int] = convertCharactersToUInt8Values(allChars)
        print(allCharValues)
    }
    
    func convertCharactersToUInt8Values(_ chars: Array<Substring>) -> [Int] {
        return chars.map{ char in
            let value = char.asciiValues.first!
            if(value > 96) {
                return (value - 96)
            } else {
                return (value - 38)
            }
        }.map{numericCast($0)}
    }
    
    func findCommonChars(_ contentTuples: Array<(String, String)>) -> Array<Substring> {
        contentTuples.map { (tuple: (String, String)) -> Substring in
            let firstHalf = tuple.0.split(separator: "")
            let secondHalf = tuple.1.split(separator: "")
            return firstHalf.filter { char in secondHalf.contains(char) }.first!
        }
    }
    
    func splitSubstringsInHalf(_ input: Array<Substring>) -> Array<(String, String)> {
        let stringArray = input.map {input -> String in String(input) }.filter{!$0.isEmpty}
        let contentTuples: Array<(String, String)> = stringArray.map{ str -> (String, String) in
            let midIndex = str.count/2
            return (String(str.prefix(midIndex)), String(str.suffix(midIndex)))
        }
        return contentTuples
    }
}
