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

func tabbedPrint(_ items: Any..., separator: String = " ", terminator: String = "\n", numTabs: Int = 1) {
    var tabs: String = ""
    var count = numTabs
    repeat {
        tabs.append("\t")
        count-=1
    } while count > 0
    
    print(tabs, terminator: "")
    print(items, separator: separator, terminator: terminator)
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset - 1)]
    }
}