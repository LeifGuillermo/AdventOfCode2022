//
//  Day2.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/1/22.
//

import Foundation

class Day2: DayProtocol {
    let sampleInput = "day2sample.txt"
    let dayInput = "day2input.txt"
    
    func readSampleInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(sampleInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    func readDayInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(dayInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
}
