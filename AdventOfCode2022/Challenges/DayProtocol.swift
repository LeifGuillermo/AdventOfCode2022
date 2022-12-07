//
//  File.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/1/22.
//

import Foundation

protocol DayProtocol {
    var sampleInput: String { get }
    var dayInput: String { get }
    func solveDay()
    func readSampleInput() -> Array<Substring>
    func readDayInput() -> Array<Substring>
    func solvePart1(_ input: [Substring])
    func solvePart2(_ input: [Substring])
}

extension DayProtocol {
    private func readInput(_ input: String) -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(input).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    func readSampleInput() -> Array<Substring> {
        return readInput(sampleInput)
    }
    
    func readDayInput() -> Array<Substring> {
        return readInput(dayInput)
    }
    
    func solveDay() {
        let sampleInput: [Substring] = readSampleInput()
        let dayInput: [Substring] = readDayInput()
        solveDayPrintInputType(sampleInput, "Part 1 with Sample Input:", solvePart1)
        solveDayPrintInputType(dayInput, "Part 1 with Day Input:", solvePart1)
        solveDayPrintInputType(sampleInput, "Part 2 with Sample Input:", solvePart2)
        solveDayPrintInputType(dayInput, "Part 2 with Day Input:", solvePart2)
    }
    
    func solveDayPrintInputType(_ input: [Substring], _ inputName: String, _ solveFunction: ([Substring]) -> Void) {
        print(inputName)
        solveFunction(input)
    }
}

enum InputType : String {
    case sampleInput = "Sample Input"
    case dayInput = "Day Input"
}
