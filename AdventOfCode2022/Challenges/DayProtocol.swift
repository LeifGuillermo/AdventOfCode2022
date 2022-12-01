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
    
    func readSampleInput() -> Array<Substring>
    func readDayInput() -> Array<Substring>
}

enum InputType : String {
    case sampleInput = "Sample Input"
    case dayInput = "Day Input"
}
