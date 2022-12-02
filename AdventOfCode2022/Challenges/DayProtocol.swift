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
}

enum InputType : String {
    case sampleInput = "Sample Input"
    case dayInput = "Day Input"
}
