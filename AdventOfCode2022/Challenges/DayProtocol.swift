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
        solvePart1(sampleInput)
        solvePart1(dayInput)
        solvePart2(sampleInput)
        solvePart2(dayInput)
    }
}

enum InputType : String {
    case sampleInput = "Sample Input"
    case dayInput = "Day Input"
}
