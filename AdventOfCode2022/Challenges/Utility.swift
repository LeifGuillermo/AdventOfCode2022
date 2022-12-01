//
//  Utility.swift
//  AdventOfCode2020
//
//  Created by Leif Guillermo on 10/23/22.
//

import Foundation

func convertSubstringArrayToIntArray(_ input: Array<Substring>) -> Array<Int> {
    return input.map {element in return Int(element) ?? 0}
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset - 1)]
    }
}
