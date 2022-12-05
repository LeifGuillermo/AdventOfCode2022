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
    
    func solvePart1(_ input: [Substring]) {
        let splitLines = splitLines(input)
        let integerValues = convertValuesToIntegers(splitLines)
        let validations: [Int] = validatePairs(integerValues, validateSinglePairFullOverlap)
        print(validations.reduce(0,+))
    }
    
    func solvePart2(_ input: [Substring]) {
        let splitLines = splitLines(input)
        let integerValues = convertValuesToIntegers(splitLines)
        let validations: [Int] = validatePairs(integerValues, validateSinglePairAnyOverlap)
        print(validations.reduce(0,+))
    }
    
    func splitLines(_ input: [Substring]) -> [[[Substring]]] {
        return input.map {
            $0.split(separator:",").map{assnmnt in assnmnt.split(separator: "-")}
        }.filter{!$0.isEmpty}
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
    
    func validatePairs(_ pairs: [[[Int]]], _ validationFunc: ((Int, Int), (Int, Int)) -> Int) -> [Int] {
        return pairs.map { pair in
            let tuple1 = (pair.first!.first!, pair.first!.last!)
            let tuple2 = (pair.last!.first!, pair.last!.last!)
            return validationFunc(tuple1, tuple2)
        }
    }
    
    func validateSinglePairFullOverlap(_ tuple1: (Int, Int),_ tuple2: (Int, Int)) -> Int{
        let leftIsInside: Bool = valueOverlapsPair(value: tuple1.0, pair: tuple2)
        && valueOverlapsPair(value: tuple1.1, pair: tuple2)
        
        let rightIsInside: Bool = valueOverlapsPair(value: tuple2.0, pair: tuple1)
        && valueOverlapsPair(value: tuple2.1, pair: tuple1)
        
        return ((leftIsInside || rightIsInside) ? 1 : 0)
    }
    
    func validateSinglePairAnyOverlap(_ tuple1: (Int, Int),_ tuple2: (Int, Int)) -> Int{
        let leftIsInside: Bool = valueOverlapsPair(value: tuple1.0, pair: tuple2)
        || valueOverlapsPair(value: tuple1.1, pair: tuple2)
        
        let rightIsInside: Bool = valueOverlapsPair(value: tuple2.0, pair: tuple1)
        || valueOverlapsPair(value: tuple2.1, pair: tuple1)
        return ((leftIsInside || rightIsInside) ? 1 : 0)
    }
    
    func valueOverlapsPair(value: Int, pair: (Int, Int)) -> Bool {
        return value >= pair.0 && value <= pair.1
    }
}
