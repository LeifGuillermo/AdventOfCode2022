//
//  Day4.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/4/22.
//

import Foundation

class Day4: DayProtocol {
    var sampleInput: String = "day4sample.txt"
    var dayInput: String = "day4input.txt"
    
    func day4() {
        let sampleInput: [Substring] = readSampleInput()
        let dayInput: [Substring] = readDayInput()
        
        solvePart1(sampleInput)
        solvePart1(dayInput)
        solvePart2(sampleInput)
        solvePart2(dayInput)
    }
    
    func solvePart1(_ input: [Substring]) {
        let splitLines = input.map {
            $0.split(separator:",").map{assnmnt in assnmnt.split(separator: "-")}
        }.filter{!$0.isEmpty}
        let integerValues = convertValuesToIntegers(splitLines)
        let validations: [Int] = validatePairs(integerValues, validateSinglePair)
        print(validations.reduce(0,+))
    }
    
    func solvePart2(_ input: [Substring]) {
        let splitLines = input.map {
            $0.split(separator:",").map{assnmnt in assnmnt.split(separator: "-")}
        }.filter{!$0.isEmpty}
        let integerValues = convertValuesToIntegers(splitLines)
        let validations: [Int] = validatePairs(integerValues, validateSinglePairAnyOverlap)
        print(validations.reduce(0,+))
    }
    
    func convertValuesToIntegers(_ values: [[[Substring]]]) -> [[[Int]]] {
        return values.map { outer in
            outer.map { middle in
                middle.map { inner in
                    Int(inner)!
                }
            }
        }
    }
    
    func validatePairs(_ pairs: [[[Int]]], _ validationFunc: ([Int], [Int]) -> Int) -> [Int] {
        return pairs.map { outer in
                return validationFunc(outer.first!, outer.last!)
        }
    }
    
    func validateSinglePair(_ pair1: [Int],_ pair2: [Int]) -> Int{
        let leftIsInside: Bool = (pair1.first! >= pair2.first! && pair1.first! <= pair2.last!)
            && (pair1.last! >= pair2.first! && pair1.last! <= pair2.last!)
        let rightIsInside: Bool = (pair2.first! >= pair1.first! && pair2.first! <= pair1.last!)
        && (pair2.last! >= pair1.first! && pair2.last! <= pair1.last!)
        return ((leftIsInside || rightIsInside) ? 1 : 0)
    }
    
    func validateSinglePairAnyOverlap(_ pair1: [Int],_ pair2: [Int]) -> Int{
        let leftIsInside: Bool = (pair1.first! >= pair2.first! && pair1.first! <= pair2.last!)
            || (pair1.last! >= pair2.first! && pair1.last! <= pair2.last!)
        let rightIsInside: Bool = (pair2.first! >= pair1.first! && pair2.first! <= pair1.last!)
        || (pair2.last! >= pair1.first! && pair2.last! <= pair1.last!)
        return ((leftIsInside || rightIsInside) ? 1 : 0)
    }
}
